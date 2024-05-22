import 'package:app_mixins/app_mixins.dart';
import 'package:app_repositories/app_repositories.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/sign_in_page/bloc/sign_in_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInView extends StatefulWidget {
  final IStorageRepository storage;
  const SignInView({super.key, required this.storage});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> with FormMixin {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
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
              final maxHeight = constraints.maxHeight;
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: kMargin.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: maxHeight * 0.15),
                        const Align(
                          alignment: Alignment.center,
                          child: Hero(tag: ('logo'), child: MyLogo()),
                        ),
                        SizedBox(height: maxHeight * 0.10),
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                        CustomTextField.email(
                          controller: emailController,
                          textLabel: ' Insira o seu login ou email',
                          validator: (value) => combine(
                            [
                              () => isNotEmpty(value),
                              //() => emailValidator(value),
                            ],
                          ),
                        ),
                        SizedBox(height: maxHeight * 0.041),
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
                        SizedBox(height: maxHeight * 0.03),
                        MyButton.loading(
                          isLoading: _isLoading,
                          text: 'Entrar',
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<SignInBloc>().add(
                                    SignInRequired(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                              await widget.storage.setLogin(
                                login: emailController,
                                password: passwordController,
                              );
                            }
                          },
                        ),
                        SizedBox(height: maxHeight * 0.02),
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
