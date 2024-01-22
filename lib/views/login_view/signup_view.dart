import 'package:fieldresearch/controller/account_controller.dart';
import 'package:fieldresearch/views/login_view/widgets/account_form.dart';
import 'package:fieldresearch/views/login_view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupView extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AccountForm(textLabel: 'Email', obscureText: false),
              SizedBox(height: 34.h),
              AccountForm(textLabel: 'Senha', obscureText: true),
              SizedBox(height: 38.h),
              MyButton(
                onPressed: () async {
                  var snack = ScaffoldMessenger.of(context);
                  if (formKey.currentState?.validate() ?? false) {
                    if (await AccountController.repositoryController
                            .signInAccount(snack) !=
                        false) {
                      AccountController.providerController.getnameUser();
                      // ignore: use_build_context_synchronously
                      AccountController.switchPage(context);
                    }
                  }
                },
              ),
              SizedBox(height: 28.h),
              // const MyButtonExternal(),
              SizedBox(height: 34.h),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Registrar',
                  style: TextStyle(
                      fontSize: 14.sp,
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      decorationColor: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
