import 'dart:developer';
import 'package:app_mixins/app_mixins.dart';
import 'package:app_ui/app_ui.dart';
import 'package:fieldresearch/screens/sign_up_page/bloc/sign_up_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user_repository/user_repository.dart';

class SignUpPage extends StatelessWidget {
  final IUserRepository userRepository;
  const SignUpPage({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(userRepository: userRepository),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> with FormMixin {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: BlocListener<SignUpBloc, ISignUpState>(
          listener: (context, state) {
            if (state is SignUpProcess) {
              setState(() {
                isLoading = true;
              });
            }
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
              clearFields();
              setState(() {
                isLoading = false;
              });
            }
            if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );

              setState(() {
                isLoading = false;
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
                    child: Column(children: [
                      SizedBox(height: maxHeight * 0.15),
                      const Hero(tag: ('logo'), child: MyLogo()),
                      SizedBox(height: maxHeight * 0.06),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      CustomTextField.email(
                        controller: emailController,
                        textLabel: 'Insira o email a ser utilizado',
                        validator: (value) => combine([
                          () => isNotEmpty(value),
                          () => emailValidator(value),
                        ]),
                      ),
                      SizedBox(height: maxHeight * 0.041),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Nome',
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      CustomTextField(
                        textLabel: 'Insira o nome de sua conta',
                        validator: (value) => combine([
                          () => isNotEmpty(value),
                        ]),
                        controller: userNameController,
                      ),
                      SizedBox(height: maxHeight * 0.041),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Senha',
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      CustomTextField.password(
                        textLabel: 'Insira a sua senha',
                        validator: (value) => combine([
                          () => isNotEmpty(value),
                          () => passwordValidador(value),
                        ]),
                        controller: passwordController,
                      ),
                      SizedBox(height: maxHeight * 0.041),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Repita a senha',
                          style: TextStyle(
                            color: MyColors.black,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      CustomTextField.password(
                        textLabel: 'Repita a sua senha',
                        validator: (value) => combine([
                          () => isNotEmpty(value),
                          () => repeatPassword(
                                value: value,
                                password: passwordController,
                                passwordagain: passwordAgainController,
                              ),
                        ]),
                        controller: passwordAgainController,
                      ),
                      SizedBox(height: maxHeight * 0.11),
                      MyButton.loading(
                          isLoading: isLoading,
                          text: 'Registrar',
                          onPressed: () async {
                            if (formKey.currentState?.validate() ?? false) {
                              context.read<SignUpBloc>().add(SignUpRequired(
                                    email: emailController.text.trim(),
                                    password:
                                        passwordAgainController.text.trim(),
                                    username: userNameController.text.trim(),
                                  ));
                            }
                          }),
                    ]),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void clearFields() {
    emailController.clear();
    userNameController.clear();
    passwordController.clear();
    passwordAgainController.clear();
  }
}
