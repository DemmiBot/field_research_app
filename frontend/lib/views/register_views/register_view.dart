import 'package:fieldresearch/controller/mixins/register_mixin.dart';
import 'package:fieldresearch/controller/register_controller.dart';
import 'package:fieldresearch/provider/loading_provider.dart';
import 'package:fieldresearch/widgets/my_button.dart';
import 'package:fieldresearch/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    RegisterController.cleanText();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder:
          (BuildContext context, LoadingProvider provider, Widget? child) =>
              GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 37.w),
                child: Column(
                  children: [
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
                        textLabel: '',
                        obscureText: false,
                        validator: (value) => combine([
                              () => isNotEmpty(value),
                              () => emailValidator(value),
                            ]),
                        controller: RegisterController.emailRegister),
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
                        controller: RegisterController.nameRegister),
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
                        controller: RegisterController.passwordRegister),
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
                              () => repeatPassword(value),
                            ]),
                        controller: RegisterController.repitPassRegister),
                    SizedBox(height: 28.h),
                    if (provider.loading)
                      const Center(child: CircularProgressIndicator()),
                    SizedBox(height: 10.h),
                    MyButton(
                        text: 'Registrar',
                        onPressed: () async {
                          if (formKey.currentState?.validate() ?? false) {
                            provider.loadingConfirm();
                            var snack = ScaffoldMessenger.of(context);
                            await RegisterController.repositoryController
                                .createUser(
                                    RegisterController.emailRegister.text
                                        .trim(),
                                    RegisterController.passwordRegister.text
                                        .trim(),
                                    snack);
                            provider.loadingConfirm();
                            RegisterController.cleanText();
                          }
                        }),
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
