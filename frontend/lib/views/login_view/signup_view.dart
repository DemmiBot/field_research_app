import 'package:fieldresearch/controller/login_controller.dart';
import 'package:fieldresearch/controller/mixins/text_field_mixin.dart';
import 'package:fieldresearch/http/http_client.dart';
import 'package:fieldresearch/repositories/login_repository.dart';
import 'package:fieldresearch/widgets/custom_text_field.dart';
import 'package:fieldresearch/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> with LoginMixin {
  final LoginController controller =
      LoginController(repository: LoginRepository(client: HttpClient()));
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
                    // n esquecer de liberar validação de email!!!!!
                    //() => emailValidator(value),
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
                AnimatedBuilder(
                    animation: controller.isloading,
                    builder: (context, child) {
                      if (controller.isloading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const SizedBox();
                      }
                    }),
                SizedBox(height: 15.h),
                MyButton(
                  text: 'Entrar',
                  onPressed: () {
                    //var snack = ScaffoldMessenger.of(context);
                    if (formKey.currentState?.validate() ?? false) {
                      controller.userLogin();
                      controller.switchPage(context);
                    }
                  },
                ),
                SizedBox(height: 34.h),
                TextButton(
                  onPressed: () {
                    controller.cleanText();
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
    );
  }
}
