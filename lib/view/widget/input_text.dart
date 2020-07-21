import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String initialValue;
  final bool readOnly;

  const InputText({
    this.label,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      initialValue: initialValue,
      validator: validator,
      readOnly: readOnly,
      onSaved: onSaved,
    );
  }
}
