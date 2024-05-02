import 'dart:developer';

import 'package:fieldresearch/screens/adm_page/create_form_view/widgets/type_data/default_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateFormView extends StatefulWidget {
  const CreateFormView({super.key});

  @override
  State<CreateFormView> createState() => _CreateFormViewState();
}

class _CreateFormViewState extends State<CreateFormView> {
  final _formKey = GlobalKey<FormBuilderState>();

  List<DefaultType> textFields = [];

  int identity = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(
              () {
                textFields.add(
                  DefaultType(
                    identity: identity++,
                  ),
                );
              },
            );
          },
          child: const Icon(Icons.add),
        ),
        body: FormBuilder(
          key: _formKey,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 26.h),
                  FormBuilderTextField(
                    name: 'name',
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nome da pesquisa...',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  const Divider(),
                  SizedBox(height: 40.w),
                  Expanded(
                    child: ListView.builder(
                        itemCount: textFields.length,
                        itemBuilder: (context, index) {
                          return textFields[index];
                        }),
                  ),
                  const SizedBox(height: 10),
                  if (textFields.isNotEmpty)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          _formKey.currentState?.save();
                          var value = _formKey.currentState!.value;
                          log('log[formKey] ==> $value');
                        },
                        child: const Text('Save and Read'),
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
