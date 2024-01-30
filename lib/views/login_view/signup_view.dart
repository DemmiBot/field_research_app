import 'package:fieldresearch/controller/login_controller.dart';
import 'package:fieldresearch/controller/mixins/text_field_mixin.dart';
import 'package:fieldresearch/provider/adm_provider.dart';
import 'package:fieldresearch/provider/loading_provider.dart';
import 'package:fieldresearch/widgets/custom_text_field.dart';
import 'package:fieldresearch/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> with LoginMixin {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<AdmProvider>(
      builder: (context, adm, child) => Consumer<LoadingProvider>(
        builder:
            (BuildContext context, LoadingProvider provider, Widget? child) =>
                GestureDetector(
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
                      validator: (shit) => combine([
                        () => isNotEmpty(shit),
                        () => passwordValidador(shit),
                      ]),
                    ),
                    SizedBox(height: 37.h),
                    if (provider.loading)
                      const Center(child: CircularProgressIndicator()),
                    SizedBox(height: 15.h),
                    MyButton(
                      text: 'Entrar',
                      onPressed: () async {
                        var snack = ScaffoldMessenger.of(context);
                        if (formKey.currentState?.validate() ?? false) {
                          provider.loadingConfirm();
                          if (await LoginController.repositoryController
                                  .signInAccount(snack) !=
                              false) {
                            adm.getnameUser();
                            provider.loadingConfirm();
                            // ignore: use_build_context_synchronously
                            LoginController.switchPage(context);
                          } else {
                            provider.loadingConfirm();
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
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                        backgroundColor: const Color.fromARGB(255, 0, 21, 255),
                      ),
                      child: const Text("Tela admin teste"),
                      onPressed: () {
                        Navigator.pushNamed(context, '/admCreateTable');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
