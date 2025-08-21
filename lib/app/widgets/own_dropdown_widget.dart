import 'package:flutter/material.dart';

class OwnDropdown<T> extends StatelessWidget {
  final String? hintText;
  final T? value;
  final List<OwnDropdownItem<T>> items;
  final Function(T?)? onChanged;

  OwnDropdown({
    Key? key,
    required this.items,
    this.hintText,
    this.onChanged,
    this.value,
  });

  InputBorder inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(width: 1, color: Color(0xffD0D5DD)),
  );

  TextStyle textStyle = const TextStyle(
    overflow: TextOverflow.ellipsis,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      onChanged: onChanged,
      isExpanded: true,
      items: items.map((item) {
        return DropdownMenuItem<T>(
          value: item.value,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              item.title,
              style: textStyle.copyWith(overflow: TextOverflow.visible),
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        hintStyle: textStyle.copyWith(color: const Color(0xff667085)),
        border: inputBorder,
        enabledBorder: inputBorder,
        errorBorder: inputBorder,
        focusedBorder: inputBorder,
        filled: true,
        fillColor: const Color(0xffF9FAFB),
        contentPadding: const EdgeInsets.symmetric(vertical: 11, horizontal: 15),
      ),
      style: textStyle.copyWith(color: const Color(0xff1f2427)),
      selectedItemBuilder: (BuildContext context) {
        return items.map<Widget>((OwnDropdownItem<T> item) {
          return SizedBox(
            width: 150,
            child: Text(
              item.title,
              // Do not include TextOverflow.ellipsis here
            ),
          );
        }).toList();
      },
    );
  }
}

class OwnDropdownItem<T> {
  final String title;
  final T value;

  OwnDropdownItem(this.title, this.value);
}