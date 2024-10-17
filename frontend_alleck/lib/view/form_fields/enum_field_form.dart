import 'package:flutter/material.dart';

class EnumFieldForm extends StatefulWidget {
  final String label;
  final List<String> options;
  final Function(String?) onSaved;

  EnumFieldForm(this.label, this.options, this.onSaved, {super.key});

  @override
  State<StatefulWidget> createState() => _EnumFieldForm();
}

class _EnumFieldForm extends State<EnumFieldForm> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: widget.label),
      items: widget.options.map(
        (String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        },
      ).toList(),
      onSaved: widget.onSaved,
      onChanged: (value) {},
    );
  }
}