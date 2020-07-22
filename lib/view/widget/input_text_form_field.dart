import 'package:flutter/material.dart';

class InputTextFormField extends StatelessWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String initialValue;
  final bool readOnly;

  const InputTextFormField({
    this.label,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    print('Вызван метод InputTextFormField#build (label $label)');
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      validator: validator,
      readOnly: readOnly,
      enabled: !readOnly,
      onSaved: onSaved,
      initialValue: initialValue,
    );
  }
}