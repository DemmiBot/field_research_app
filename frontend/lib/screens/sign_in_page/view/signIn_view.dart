import 'package:fieldresearch/controller/mixins/text_field_mixin.dart';
import 'package:fieldresearch/screens/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:fieldresearch/widgets/custom_text_field.dart';
import 'package:fieldresearch/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> with LoginMixin {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BlocListener<SignInBloc, ISignInState>(
          listener: (context, state) {
            if (state is SignInProcess) {
              setState(() {
                isLoading = true;
              });
            } else if (state is SignInFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(state.message ?? 'Erro ao autenticar seu usuário.'),
                ),
              );
              setState(() {
                isLoading = false;
              });
            } else {
              setState(() {
                isLoading = false;
              });
            }
          },
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 37.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    controller: emailController,
                    textLabel: ' Email',
                    obscureText: false,
                    validator: (value) => combine(
                      [
                        () => isNotEmpty(value),
                        // n esquecer de liberar validação de email!!!!!
                        //() => emailValidator(value),
                      ],
                    ),
                  ),
                  SizedBox(height: 34.h),
                  CustomTextField(
                    controller: passwordController,
                    textLabel: ' Senha',
                    obscureText: true,
                    validator: (shit) => combine([
                      () => isNotEmpty(shit),
                      () => passwordValidador(shit),
                    ]),
                  ),
                  SizedBox(height: 37.h),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                  SizedBox(height: 15.h),
                  MyButton(
                    text: 'Entrar',
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        context.read<SignInBloc>().add(
                              SignInRequired(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              ),
                            );
                      }
                    },
                  ),
                  SizedBox(height: 34.h),
                  TextButton(
                    onPressed: () {
                      // controller.cleanText();
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
