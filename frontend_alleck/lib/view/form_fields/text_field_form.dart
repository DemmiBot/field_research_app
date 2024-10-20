
import 'package:flutter/material.dart';

class TextFieldForm extends StatefulWidget{
  final String label;
  final Function(String?) onSaved;

  TextFieldForm(this.label, this.onSaved, {super.key});
  
  @override
  State<StatefulWidget> createState() => _TextFieldForm();    
}

class _TextFieldForm extends State<TextFieldForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: widget.label),
      onSaved: widget.onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo vazio!';
        }
        return null;
      }
    );
  }
}