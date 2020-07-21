import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;

  const InputText({
    this.label, this.onSaved, this.validator
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      validator: validator,
      onSaved: onSaved,
    );
  }
}
