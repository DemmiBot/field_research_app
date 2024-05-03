import 'package:fieldresearch/controller/mixins/text_field_mixin.dart';
import 'package:fieldresearch/screens/sign_up_page/bloc/sign_up_bloc.dart';
import 'package:fieldresearch/widgets/custom_text_field.dart';
import 'package:fieldresearch/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with FormMixin {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordAgainController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: BlocListener<SignUpBloc, ISignUpState>(
          listener: (context, state) {
            if (state is SignUpProcess) {
              setState(() {
                isLoading = true;
              });
            } else if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cadastrado com sucesso'),
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
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.w),
                child: Column(children: [
                  SizedBox(height: 90.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Email para cadastro',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  CustomTextField(
                    controller: emailController,
                    textLabel: '',
                    obscureText: false,
                    validator: (value) => combine([
                      () => isNotEmpty(value),
                      () => emailValidator(value),
                    ]),
                  ),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Nome',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  CustomTextField(
                    textLabel: '',
                    obscureText: false,
                    validator: (value) => combine([
                      () => isNotEmpty(value),
                    ]),
                    controller: nameController,
                  ),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Senha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  CustomTextField(
                    textLabel: '',
                    obscureText: false,
                    validator: (value) => combine([
                      () => isNotEmpty(value),
                      () => passwordValidador(value),
                    ]),
                    controller: passwordController,
                  ),
                  SizedBox(height: 14.h),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Repita a senha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  CustomTextField(
                      textLabel: '',
                      obscureText: false,
                      validator: (value) => combine([
                            () => isNotEmpty(value),
                            // () => repeatPassword(value),
                          ]),
                      controller: passwordAgainController),
                  SizedBox(height: 28.h),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator()),
                  SizedBox(height: 10.h),
                  MyButton(
                      text: 'Registrar',
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          context.read<SignUpBloc>().add(SignUpRequired(
                                login: emailController.text.trim(),
                                password: passwordAgainController.text.trim(),
                              ));
                          emailController.clear();
                          nameController.clear();
                          passwordController.clear();
                          passwordAgainController.clear();
                        }
                      }),
                ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
