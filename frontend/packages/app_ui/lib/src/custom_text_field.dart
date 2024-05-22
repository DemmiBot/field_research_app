import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'constants.dart';

class CustomTextField extends StatefulWidget {
  final String textLabel;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool isPassword;

  const CustomTextField({
    Key? key,
    required this.textLabel,
    required this.validator,
    required this.controller,
    this.textInputType,
    this.isPassword = false,
  }) : super(key: key);

  const CustomTextField.email({
    Key? key,
    required this.textLabel,
    required this.validator,
    required this.controller,
  })  : textInputType = TextInputType.emailAddress,
        isPassword = false,
        super(key: key);

  const CustomTextField.password({
    Key? key,
    required this.textLabel,
    required this.validator,
    required this.controller,
  })  : textInputType = null,
        isPassword = true,
        super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.textInputType,
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.isPassword ? obscureText : false,
      cursorColor: MyColors.black,
      cursorHeight: 20.h,
      style: TextStyle(color: MyColors.black, fontSize: 14.sp),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: MyColors.borderField),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(color: MyColors.borderField),
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: obscureText
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
                onPressed: () => setState(() => obscureText = !obscureText),
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.h),
        filled: true,
        fillColor: MyColors.textFill,
        hintText: widget.textLabel,
        hintStyle: TextStyle(color: MyColors.borderField, fontSize: 14.sp),
      ),
    );
  }
}
