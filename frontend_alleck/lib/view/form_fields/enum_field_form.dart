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
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    // Set the default selected value to the first option
    _selectedValue = widget.options.isNotEmpty ? widget.options[0] : null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(labelText: widget.label),
      value: _selectedValue,  // Set the selected value
      items: widget.options.map(
        (String option) {
          return DropdownMenuItem<String>(
            value: option,
            child: Text(option),
          );
        },
      ).toList(),
      onSaved: widget.onSaved,
      onChanged: (value) {
        setState(() {
          _selectedValue = value;  // Update selected value
        });
      },
    );
  }
}