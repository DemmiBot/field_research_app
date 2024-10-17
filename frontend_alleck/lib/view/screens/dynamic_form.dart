import 'package:flutter/material.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/view/form_fields/enum_field_form.dart';
import 'package:frontend_alleck/view/form_fields/int_field_form.dart';
import 'package:frontend_alleck/view/form_fields/text_field_form.dart';

class DynamicForm extends StatefulWidget {
  final List<Question> fields;

  DynamicForm({required this.fields});

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends State<DynamicForm> {
  final _formKey = GlobalKey<FormState>();

  // Store form values as a List of Strings
  late List<String?> formData;

  @override
  void initState() {
    super.initState();
    // Initialize formData with null values, matching the length of the fields list
    formData = List.filled(widget.fields.length, null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dynamic Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...widget.fields.asMap().entries.map((entry) {
                int index = entry.key;
                Question field = entry.value;

                // Choose the widget based on fieldType
                switch (field.type) {
                  case 'text':
                    return TextFieldForm(field.text, (value) {
                      formData[index] = value;
                    });
                  case 'integer':
                    return IntFieldForm(field.text, (value) {
                      formData[index] = value;
                    });
                  case 'enum':
                    return EnumFieldForm(field.text, field.enumValues ?? [], (value) {
                      formData[index] = value;
                    });
                  default:
                    return SizedBox(); // Empty widget for unrecognized types
                }
              }).toList(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Process formData
                    print(formData); // Values will be in order of the fields list
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}