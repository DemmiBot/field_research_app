
import 'package:flutter/material.dart';

class IntFieldForm extends StatefulWidget{
  final String label;
  final int? maxValue;
  final int? minValue;
  final Function(String?) onSaved;

  IntFieldForm(this.label, this.onSaved,{super.key, this.maxValue, this.minValue});
  
  @override
  State<StatefulWidget> createState() => _IntFieldForm();    
}

class _IntFieldForm extends State<IntFieldForm> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: widget.label),
      keyboardType: TextInputType.numberWithOptions(),
      onSaved: widget.onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Campo vazio!';
        }
        if(double.tryParse(value) == null) {
          return 'Campo numérico';
        }
        if (widget.minValue != null && double.parse(value) < widget.minValue!) {
          return 'Valor mínimo aceito é ${widget.minValue}';
        }
        if (widget.maxValue != null && double.parse(value) > widget.maxValue!) {
          return 'Valor máximo aceito é ${widget.minValue}';
        }
        return null;
      },
    );
  }
}

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.tryParse(s) != null;
}