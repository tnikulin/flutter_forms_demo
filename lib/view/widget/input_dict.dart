import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/entity/dictionary.dart';

class InputDict extends StatelessWidget {
  final String label;
  final ValueChanged<Dictionary> onChanged;
  final List<Dictionary> items;
  final FormFieldValidator<Dictionary> validator;

  const InputDict(
      {Key key, this.label, this.onChanged, this.items, this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Dictionary>(
        onChanged: onChanged,
        icon: Icon(Icons.arrow_drop_down),
        decoration: InputDecoration(labelText: label),
        validator: validator,
        items: items
            .map((Dictionary value) => DropdownMenuItem<Dictionary>(
                  value: value,
                  child: Text(value.name),
                ))
            .toList());
  }
}
