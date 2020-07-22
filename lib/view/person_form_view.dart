import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/entity/person.dart';
import 'package:flutter_form_demo/view/widget/input_text_form_field.dart';

/// Пример view, который можно переиспользовать в формах
class PersonFormView extends StatelessWidget {
  final Person person;
  final String label;

  const PersonFormView({Key key, this.person, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(children: [
          Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          InputTextFormField(
              label: 'Имя', onSaved: (val) => person.firstName = val),
          InputTextFormField(
              label: 'Фамилия', onSaved: (val) => person.lastName = val),
        ]));
  }
}
