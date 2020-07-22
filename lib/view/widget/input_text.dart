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
//      key: UniqueKey(), // TODO tn без нее initialValue обновляется с задержкой
    // TODO tn вероятно потому, что reset() этого поля при ресете формы сбрасывает значение к initialValue
      decoration: InputDecoration(labelText: label),
      initialValue: initialValue,

      validator: validator,
      readOnly: readOnly,
      enabled: !readOnly,
      onSaved: onSaved,
//      controller: TextEditingController(text: initialValue),
    );
  }
}
