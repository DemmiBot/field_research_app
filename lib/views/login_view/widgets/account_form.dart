import 'package:fieldresearch/controller/account_controller.dart';
import 'package:fieldresearch/controller/mixins/login_mixins.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AccountForm extends StatelessWidget with LoginMixin {
  String textLabel = '';
  bool obscureText = false;
  var controller = TextEditingController();
  AccountForm({super.key, required this.textLabel, required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 37.w),
      child: TextFormField(
        validator: (value) => combine([
          () => isNotEmpty(value),
          if (obscureText == false) () => emailValidator(value),
          if (obscureText) () => passwordValidador(value),
        ]),
        controller: obscureText
            ? AccountController.passwordController
            : AccountController.emailController,
        obscureText: obscureText,
        cursorColor: Colors.white,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          filled: true,
          fillColor: fillForm,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide.none,
          ),
          hintText: textLabel,
          hintStyle: TextStyle(color: textColorForm, fontSize: 16.sp),
        ),
      ),
    );
  }
}
