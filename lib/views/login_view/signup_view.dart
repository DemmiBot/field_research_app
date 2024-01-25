import 'package:fieldresearch/controller/login_controller.dart';
import 'package:fieldresearch/controller/mixins/login_mixin.dart';
import 'package:fieldresearch/provider/adm_provider.dart';
import 'package:fieldresearch/widgets/custom_text_field.dart';
import 'package:fieldresearch/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> with LoginMixin {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AdmProvider>(
      builder: (context, adm, child) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: LoginController.emailController,
                    textLabel: ' Email',
                    obscureText: false,
                    validator: (value) => combine([
                      () => isNotEmpty(value),
                      () => emailValidator(value),
                    ]),
                  ),
                  SizedBox(height: 34.h),
                  CustomTextField(
                    controller: LoginController.passwordController,
                    textLabel: ' Senha',
                    obscureText: true,
                    validator: (value) => combine([
                      () => isNotEmpty(value),
                      () => passwordValidador(value),
                    ]),
                  ),
                  SizedBox(height: 37.h),
                  if (LoginController.loading)
                    const Center(child: CircularProgressIndicator()),
                  SizedBox(height: 15.h),
                  MyButton(
                    text: 'Entrar',
                    onPressed: () async {
                      var snack = ScaffoldMessenger.of(context);
                      if (formKey.currentState?.validate() ?? false) {
                        setState(() {
                          LoginController.loading = true;
                        });
                        if (await LoginController.repositoryController
                                .signInAccount(snack) !=
                            false) {
                          adm.getnameUser();
                          // ignore: use_build_context_synchronously
                          LoginController.switchPage(context);
                          LoginController.loading = false;
                        }
                      }
                    },
                  ),
                  SizedBox(height: 28.h),
                  // const MyButtonExternal(),
                  SizedBox(height: 34.h),
                  TextButton(
                    onPressed: () {
                      LoginController.cleanText();
                      Navigator.pushNamed(context, '/register');
                    },
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
        ),
      ),
    );
  }
}
