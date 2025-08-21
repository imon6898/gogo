import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../themes/app_theme.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final String? heighLabelText;
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Function(String)? onChanged;
  final int? textFieldHeight;
  final FocusNode? focusNode;
  final Icon? prefixIcon;
  final IconButton? suffixIcon;
  final int? minLines;
  final int? maxLines;
  final bool isDisposed;
  final AutovalidateMode autovalidateMode;

  const CustomTextField({
    this.validator,
    this.heighLabelText,
    this.labelText,
    this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.textFieldHeight = 40,
    this.focusNode,
    this.prefixIcon,
    this.suffixIcon,
    this.minLines,
    this.maxLines,
    this.isDisposed = false,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    focusNode?.addListener(() {
      if (focusNode!.hasFocus && !isDisposed) {
        onChanged?.call(controller?.text ?? "");
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (heighLabelText != null)
          Padding(
            padding: EdgeInsets.only(bottom: 5.h),
            child: Text(
              heighLabelText!,
              style: CustomTextStyles.medium16.copyWith(
                color: AppTheme.isDarkMode(context)
                    ? CustomColors.white
                    : CustomColors.black,
              ),
            ),
          ),
        TextFormField(
          autovalidateMode: autovalidateMode,
          validator: validator,
          focusNode: focusNode,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          minLines: minLines ?? 1,
          maxLines: obscureText ? 1 : (maxLines ?? 1),
          onChanged: (value) {
            if (!isDisposed) {
              onChanged?.call(value);
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 12.w,
            ),
            hintText: hintText,
            hintStyle: CustomTextStyles.regular14.copyWith(color: Colors.grey),
            labelText: labelText,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.black, width: 1.0.w),
              borderRadius: BorderRadius.circular(10.0).r,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CustomColors.PrimaryColor, width: 1.0),
              borderRadius: BorderRadius.circular(10.0).r,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(10.0).r,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red, width: 1.0),
              borderRadius: BorderRadius.circular(10.0).r,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0).r,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
          ),
        ),
      ],
    );
  }
}
