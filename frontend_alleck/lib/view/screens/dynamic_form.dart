import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend_alleck/model/poll.dart';
import 'package:frontend_alleck/providers/api_client_provider.dart';
import 'package:frontend_alleck/view/form_fields/enum_field_form.dart';
import 'package:frontend_alleck/view/form_fields/int_field_form.dart';
import 'package:frontend_alleck/view/form_fields/text_field_form.dart';

/* O propósito dessa tela é gerar um formulário a partir das opções obtidas de uma poll e retornar uma entry, uma lista de Strings com as respostas.
  Futuras atualizações: backend: Campos obrigatórios ou não e aceitar enumerados, assim como limites máximos e mínimos de numéricos
  frontend: aplicar constrições descritas acima
 */

class DynamicForm extends ConsumerStatefulWidget {
  final int pollId;
  final List<Question> fields;

  DynamicForm({required this.fields, required this.pollId});

  @override
  _DynamicFormState createState() => _DynamicFormState();
}

class _DynamicFormState extends ConsumerState<DynamicForm> {
  final _formKey = GlobalKey<FormState>();

  // Store form values as a List of Strings
  late List<String?> formData;

  @override
  void initState() {
    super.initState();
    // Initialize formData with null values, matching the length of the fields list
    formData = List.filled(widget.fields.length, null);
  }

  void _submitEntry() async {
    final apiClient = ref.read(apiClientProvider);

    final data = {
      'pollId': widget.pollId,
      'responses': formData
    };

    try {
      final response = await apiClient.post('entries', data);
      print('Formulário criado com sucesso: $response');
      Navigator.pop(context);
    } catch (e) {
      print('Failed to create form: $e');
    }
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
                    return TextFieldForm(field.label, (value) {
                      formData[index] = value;
                    });
                  case 'numerical':
                    return IntFieldForm(field.label, (value) {
                      formData[index] = value;
                    });
                  case 'enum':
                    return EnumFieldForm(field.label, field.enumValues ?? [], (value) {
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
                    _submitEntry();
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