import 'package:fieldresearch/utils/utils.dart';
import 'package:fieldresearch/views/adm_views/create_form_view/widgets/add_item.dart';
import 'package:fieldresearch/views/adm_views/create_form_view/widgets/circle_more.dart';
import 'package:fieldresearch/views/adm_views/create_form_view/widgets/obrigatory_field.dart';
import 'package:fieldresearch/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateFormView extends StatefulWidget {
  const CreateFormView({super.key});

  @override
  State<CreateFormView> createState() => _CreateFormViewState();
}

class _CreateFormViewState extends State<CreateFormView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 26.h),
                Text('Nome da pesquisa...',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                const Divider(),
                SizedBox(height: 40.w),
                _layoutFormArrow(' Perfil', null, null, 286.w),
                SizedBox(height: 4.h),
                const ObrigatoryField(),
                SizedBox(height: 26.h),
                _layoutFormArrow(' Nome do Candidato', null, null, 286.w),
                SizedBox(height: 4.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 286.w),
                  child: CustomTextField(
                      textLabel: ' nome_do_candidato',
                      heigth: 10.h,
                      obscureText: false,
                      validator: null,
                      controller: null),
                ),
                SizedBox(height: 4.h),
                _layoutFormObrigatory(' Texto', 5.w),
                const Divider(color: fillFormColor),
                SizedBox(height: 7.h),
                _layoutFormArrow(' Genêro', null, null, 286.w),
                SizedBox(height: 4.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 286.w),
                  child: CustomTextField(
                      textLabel: ' genero',
                      heigth: 10.h,
                      obscureText: false,
                      validator: null,
                      controller: null),
                ),
                SizedBox(height: 4.h),
                _layoutFormArrow(' Masculino', null, null, 203.w),
                SizedBox(height: 4.h),
                _layoutFormArrow(' Feminino', null, null, 203.w),
                SizedBox(height: 4.h),
                const AddItem(),
                SizedBox(height: 4.h),
                _layoutFormObrigatory(' Enumerado', 5.w),
                SizedBox(height: 4.h),
                const Divider(color: fillFormColor),
                SizedBox(height: 4.h),
                _layoutFormArrow(' Idade', null, null, 286.w),
                SizedBox(height: 4.h),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 286.w),
                  child: CustomTextField(
                      textLabel: ' idade',
                      heigth: 10.h,
                      obscureText: false,
                      validator: null,
                      controller: null),
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    _layoutFormAge(' 18', ' Mínimo', 65.w),
                    SizedBox(width: 4.h),
                    _layoutFormAge(' 18', ' Máximo', 65.w),
                  ],
                ),
                SizedBox(height: 4.h),
                _layoutFormObrigatory(' Inteiro', 5.w),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      )),
    );
  }

  Row _layoutFormArrow(textLabel, controller, validator, width) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: width),
          child: CustomTextField(
              textLabel: textLabel,
              obscureText: false,
              validator: validator,
              controller: controller,
              heigth: 10.h),
        ),
        SizedBox(width: 2.w),
        const CircleMore(),
      ],
    );
  }

  Row _layoutFormObrigatory(textLabel, sizedBox) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 121.w),
          child: CustomTextField(
              textLabel: textLabel,
              suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.expand_more_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
              obscureText: false,
              validator: null,
              controller: null,
              heigth: 10.h),
        ),
        SizedBox(width: sizedBox),
        const ObrigatoryField(),
      ],
    );
  }

  Row _layoutFormAge(textLabel, text, maxWidth) {
    return Row(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: CustomTextField(
              textLabel: textLabel,
              suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.expand_more_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
              obscureText: false,
              validator: null,
              controller: null,
              heigth: 10.h),
        ),
        SizedBox(width: 3.w),
        Text(text, style: TextStyle(color: Colors.white, fontSize: 12.sp)),
      ],
    );
  }
}
