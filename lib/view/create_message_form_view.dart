import 'package:flutter/material.dart';
import 'package:flutter_form_demo/view/widget/input_text.dart';

class CreateMessageFormView extends StatefulWidget {
  final model;

  const CreateMessageFormView({Key key, this.model}) : super(key: key);

  @override
  _CreateMessageFormViewState createState() {
    print('Вызван метод CreateMessageFormView#createState');
    return _CreateMessageFormViewState();
  }
}

class _CreateMessageFormViewState extends State<CreateMessageFormView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('Вызван метод _CreateMessageFormViewState#build');
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        InputText(
            label: 'Поле 1',
            onSaved: (val) => widget.model.message.field1 = val,
            validator: (value) => value.isEmpty ? 'Заполните поле 1' : null),
        InputText(
            label: 'Поле 2',
            onSaved: (val) => widget.model.message.field2 = val),
        Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: RaisedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    widget.model.save();
                  }
                },
                child: Text('Сохранить'))),
      ]),
    );
  }
}
