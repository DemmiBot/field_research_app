
import 'package:flutter/material.dart';

class IntFieldForm extends StatefulWidget{
  final String label;
  final Function(String?) onSaved;

  IntFieldForm(this.label, this.onSaved, {super.key});
  
  @override
  State<StatefulWidget> createState() => _IntFieldForm();    
}

class _IntFieldForm extends State<IntFieldForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: widget.label),
      onSaved: widget.onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a value for $widget.label';
        }
        return null;
      },
    );
  }
}