import 'package:app_mixins/app_mixins.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with FormMixin {
  final formKey = GlobalKey<FormState>();

  TextEditingController loginController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final signInBloc = context.read<SignInBloc>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BlocListener<SignInBloc, ISignInState>(
          listener: (context, state) {
            if (state is SignInProcess) {
              setState(() {
                _isLoading = true;
              });
            } else if (state is SignInFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content:
                      Text(state.message ?? 'Erro ao autenticar seu usuário.'),
                ),
              );
              setState(() {
                _isLoading = false;
              });
            } else {
              setState(() {
                _isLoading = false;
              });
            }
          },
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kMargin.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 120.h),
                        const Align(
                          alignment: Alignment.center,
                          child: Hero(tag: ('logo'), child: MyLogo()),
                        ),
                        SizedBox(height: 85.h),
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        CustomTextField.email(
                          controller: loginController,
                          textLabel: ' Insira o seu login ou email',
                          validator: (value) => combine(
                            [
                              () => isNotEmpty(value),
                            ],
                          ),
                        ),
                        SizedBox(height: 31.h),
                        Text(
                          'Senha',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        CustomTextField.password(
                          controller: passwordController,
                          textLabel: ' Insira a sua senha',
                          validator: (shit) => combine([
                            () => isNotEmpty(shit),
                            () => passwordValidador(shit),
                          ]),
                        ),
                        SizedBox(height: 30.h),
                        MyButton.loading(
                          isLoading: _isLoading,
                          text: 'Entrar',
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              signInBloc.add(
                                SignInRequiredAndSave(
                                  login: loginController,
                                  password: passwordController,
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 18.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Não possui login?',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/register');
                              },
                              child: Text(
                                ' Registre-se!',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: MyColors.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
