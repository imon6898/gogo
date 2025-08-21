import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../themes/app_theme.dart';
import '../utils/constants/app_colors.dart';

enum SelectionMode { single, multi }

class CustomSelectSection<T> extends StatefulWidget {
  final String hintText;
  final Map<T, String> items; // Map of ID -> Name
  final List<T> selectedItems; // List of selected IDs (dynamic type)
  final String? labelText;
  final bool? filled;
  final Color? fillColor;
  final ValueChanged<List<T>> onChangedSelection;
  final bool isRequired;
  final bool labelOnBoard;
  final FormFieldValidator<List<T>>? validator;
  final bool searchRequired;
  final TextEditingController? controller;
  final AutovalidateMode autovalidateMode;
  final SelectionMode selectionMode;
  final String? errorMessage; // New parameter for error message

  const CustomSelectSection({
    Key? key,
    required this.hintText,
    required this.items,
    required this.selectedItems,
    this.labelText,
    required this.onChangedSelection,
    this.isRequired = false,
    this.labelOnBoard = false,
    this.validator,
    this.controller,
    this.filled = true,
    this.fillColor,
    this.searchRequired = false,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.selectionMode = SelectionMode.single,
    this.errorMessage, // Accept error message
  }) : super(key: key);

  @override
  _CustomSelectSectionState<T> createState() => _CustomSelectSectionState<T>();
}

class _CustomSelectSectionState<T> extends State<CustomSelectSection<T>> {
  List<T> selectedItems = [];
  bool isDropdownOpen = false;
  String searchQuery = '';
  List<T> filteredItems = [];
  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.selectedItems);
    _updateFilteredItems();

    if (widget.controller != null && selectedItems.isNotEmpty) {
      widget.controller!.text = widget.items[selectedItems.first] ?? '';
    }

    _searchFocusNode.addListener(() {
      if (_searchFocusNode.hasFocus && !isDropdownOpen) {
        setState(() {
          isDropdownOpen = true;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant CustomSelectSection<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.items != oldWidget.items) {
      _updateFilteredItems();
    }

    if (widget.selectedItems != oldWidget.selectedItems) {
      setState(() {
        selectedItems = List.from(widget.selectedItems);
      });
    }
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    _searchController.dispose();
    _removeOverlay();

    super.dispose();
  }

  void _toggleDropdown() {
    if (_overlayEntry == null) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
    setState(() {
      if (isDropdownOpen) {
        FocusScope.of(context).requestFocus(_searchFocusNode);
      } else {
        _searchFocusNode.unfocus();
      }
    });
  }

  void _onItemChanged(T item) {
    setState(() {
      if (widget.selectionMode == SelectionMode.single) {
        selectedItems = [item]; // Only allow one item to be selected
      } else {
        if (selectedItems.contains(item)) {
          selectedItems.remove(item);
        } else {
          selectedItems.add(item);
        }
      }
      widget.onChangedSelection(selectedItems);
    });

    // Close the overlay when selectionMode is single
    if (widget.selectionMode == SelectionMode.single) {
      _removeOverlay();
    } else {
      // Refresh the overlay after state change
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _removeOverlay();
        _showOverlay();
      });
    }
  }

  void _filterItems(String query) {
    setState(() {
      searchQuery = query;
      _updateFilteredItems();
    });

    // Update overlay after filtering
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removeOverlay();
      _showOverlay();
    });
  }

  void _updateFilteredItems() {
    setState(() {
      filteredItems = widget.items.keys
          .where((item) => widget.items[item]?.toLowerCase().contains(searchQuery.toLowerCase()) ?? false)
          .toList();
    });
  }

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  void _showOverlay() {
    setState(() {
      isDropdownOpen = true;  // Set dropdown to open when the overlay is shown
    });
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    // Only call setState if the widget is still mounted
    if (mounted) {
        isDropdownOpen = false;
    }
  }


  void _removeSelectedItem(T item) {
    setState(() {
      selectedItems.remove(item);
      widget.onChangedSelection(selectedItems);
    });

    // Refresh the overlay based on selection mode
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _removeOverlay();
    });
  }

  final GlobalKey _containerKey = GlobalKey();
  OverlayEntry _createOverlayEntry() {
    final RenderBox? renderBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    final double containerHeight = renderBox?.size.height ?? 70;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width * 0.923,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: Offset(0, containerHeight + 10),
          child: Material(
            elevation: 4,
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: AppTheme.isDarkMode(context) ? CustomColors.black : CustomColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: filteredItems.map((itemId) {
                      final itemName = widget.items[itemId];
                      if (itemName == null) return const SizedBox.shrink();
                      final isSelected = selectedItems.contains(itemId);
                      return GestureDetector(
                        onTap: () => _onItemChanged(itemId),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blue : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue),
                          ),
                          child: Text(
                            itemName,
                            style: TextStyle(
                              fontSize: 13,
                              color: isSelected ? Colors.white : (AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<List<T>>(
      initialValue: selectedItems,
      validator: widget.isRequired
          ? (value) => value == null || value.isEmpty ? "${widget.hintText} is required" : null
          : widget.validator,
      autovalidateMode: widget.autovalidateMode,
      builder: (FormFieldState<List<T>> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.labelText != null && !widget.labelOnBoard) ...[
              Text(
                widget.labelText!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: state.hasError ? Colors.red : (AppTheme.isDarkMode(context)
                      ? CustomColors.white
                      : CustomColors.black),
                ),
              ),
              SizedBox(height: 5.h),
            ],
            CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                key: _containerKey,
                onTap: _toggleDropdown,
                child: widget.labelOnBoard
                    ? InputDecorator(
                  decoration: InputDecoration(
                    fillColor: widget.fillColor ??
                        (AppTheme.isDarkMode(context)
                            ? CustomColors.black
                            : CustomColors.white),
                    filled: widget.filled,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    label: !isDropdownOpen
                        ? selectedItems.isNotEmpty
                        ? Text(
                      widget.labelText!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: state.hasError ? Colors.red : (AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black),
                      ),
                    )
                        : RichText(text: const TextSpan())
                        : Text(widget.hintText),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelStyle: TextStyle(
                      color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            selectedItems.isNotEmpty
                                ? Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: (AppTheme.isDarkMode(context)
                                    ? CustomColors.black
                                    : CustomColors.white),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(width: 1, color: Colors.blueGrey),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: selectedItems.map((item) {
                                  final itemName = widget.items[item];
                                  return Text(
                                    itemName ?? '',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                                    ),
                                  );
                                }).toList(),
                              ),
                            )
                                : !isDropdownOpen
                                ? Text(
                              widget.hintText,
                              style: TextStyle(
                                color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                              ),
                            )
                                : Container(),
                            if (isDropdownOpen && widget.searchRequired) ...[
                              const SizedBox(height: 5),
                              TextField(
                                focusNode: _searchFocusNode,
                                controller: _searchController,
                                onChanged: _filterItems,
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                                  ),
                                ),
                                style: TextStyle(
                                  color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                      ),
                    ],
                  ),
                )
                    : Container(
                  constraints: BoxConstraints(minHeight: 40.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 1, color: CustomColors.black),
                    color: widget.fillColor ?? (AppTheme.isDarkMode(context)
                        ? CustomColors.black
                        : CustomColors.white),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            selectedItems.isNotEmpty
                                ? Wrap(
                              alignment: WrapAlignment.start,
                              spacing: 8.0,
                              runSpacing: 0.0,
                              children: selectedItems.isNotEmpty
                                  ? selectedItems.map((item) {
                                final itemName = widget.items[item];
                                if (itemName == null) {
                                  return const SizedBox();
                                }
                                return Chip(
                                  backgroundColor: AppTheme.isDarkMode(context) ? CustomColors.black : CustomColors.white,
                                  labelPadding: EdgeInsets.all(2),
                                  padding: EdgeInsets.all(5),
                                  label: SizedBox(
                                    height: 20,
                                    child: Text(
                                      itemName,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                                      ),
                                    ),
                                  ),
                                  deleteIcon: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.redAccent, width: 1),
                                    ),
                                    child: const Icon(Icons.close, size: 13, color: Colors.red),
                                  ),
                                  onDeleted: () => _removeSelectedItem(item),
                                );
                              }).toList()
                                  : [const SizedBox()],
                            )
                                : (!isDropdownOpen || (isDropdownOpen && !widget.searchRequired))
                                ? Text(
                              widget.hintText,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                              ),
                            )
                                : const SizedBox(),
                            if (isDropdownOpen && widget.searchRequired) ...[
                              Container(
                                height: 40.h,
                                width: MediaQuery.of(context).size.width * 0.5,
                                padding: EdgeInsets.symmetric(vertical: 4.h),
                                child: TextField(
                                  focusNode: _searchFocusNode,
                                  controller: _searchController,
                                  onChanged: _filterItems,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: 6.h,
                                      horizontal: 6.w,
                                    ),
                                    hintText: 'Search...',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 14,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey,
                                        width: 1.0,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                                  ),
                                  style: TextStyle(
                                    color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      Icon(
                        isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                        color: AppTheme.isDarkMode(context) ? CustomColors.white : CustomColors.black,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  widget.errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}