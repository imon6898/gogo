import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gogo/app/utils/constants/app_assets.dart';
import 'package:gogo/app/utils/constants/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final String hintText;
  final Color fillColor;
  final Color borderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;
  final double? borderWidth;

  const CustomSearchField({
    Key? key,
    required this.controller,
    this.onChanged,
    this.hintText = 'Search...',
    this.fillColor = Colors.white,
    this.borderColor = Colors.black,
    this.borderRadius = 30.0,
    this.padding,
    this.onTap,
    this.borderWidth = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(color: borderColor, width: borderWidth ?? 1.0),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                textInputAction: TextInputAction.search,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.sp,
                ),
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 14.sp,
                  ),
                  filled: true,
                  fillColor: fillColor,
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius.r),
                      bottomLeft: Radius.circular(borderRadius.r),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius.r),
                      bottomLeft: Radius.circular(borderRadius.r),
                    ),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadius.r),
                      bottomLeft: Radius.circular(borderRadius.r),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: onTap,
              child: Container(
                height: 48.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: CustomColors.mainColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(borderRadius.r),
                    bottomRight: Radius.circular(borderRadius.r),
                  ),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    ImageUtils.mdflogosearch,
                    color: Colors.white,
                    height: 50.h,
                    width: 50.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
