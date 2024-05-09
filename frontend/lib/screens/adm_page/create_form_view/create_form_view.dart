import 'dart:developer';

import 'package:app_mixins/app_mixins.dart';
import 'package:fieldresearch/screens/adm_page/create_form_view/bloc/create_form_bloc.dart';
import 'package:fieldresearch/screens/adm_page/create_form_view/widgets/default_type.dart';
import 'package:fieldresearch/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateFormView extends StatefulWidget {
  const CreateFormView({super.key});

  @override
  State<CreateFormView> createState() => _CreateFormViewState();
}

class _CreateFormViewState extends State<CreateFormView> with FormMixin {
  final _formKey = GlobalKey<FormBuilderState>();

  List<DefaultType> textFields = [];

  int identity = -1;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocListener<CreateFormBloc, ICreateFormState>(
        listener: (context, state) {
          if (state is CreateFormFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
          if (state is CreateFormSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
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
                      validator: (value) => isNotEmptyFlutterForm(value),
                      name: 'name',
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Nome da pesquisa...',
                        hintStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    FormBuilderTextField(
                      validator: (value) => isNotEmptyFlutterForm(value),
                      maxLines: 3,
                      name: 'description',
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: fillFormColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(3.r),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Descrição...',
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: textFields.length,
                        itemBuilder: (context, index) {
                          return textFields[index];
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (textFields.isNotEmpty)
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.saveAndValidate()) {
                              var value = _formKey.currentState!.value;
                              log('log[formKey] ==> $value');
                              context.read<CreateFormBloc>().add(
                                    ResetStateBloc(),
                                  );
                              context.read<CreateFormBloc>().add(
                                    CreateFormRequired(pollData: value),
                                  );
                            }
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
      ),
    );
  }
}
