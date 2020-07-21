import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/create_message_model.dart';

class CreateMessageView extends StatefulWidget {
  @override
  _CreateMessageViewState createState() => _CreateMessageViewState();
}

class _CreateMessageViewState extends State<CreateMessageView> {
  final _formKey = GlobalKey<FormState>();
  final _model = CreateMessageModel();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        TextFormField(
          decoration: InputDecoration(labelText: 'Поле 1'),
          validator: (value) {
            if (value.isEmpty) {
              return 'Заполните поле 1';
            }
          },
          onSaved: (val) => setState(() => _model.message.field1 = val),
        ),
        TextFormField(
            decoration: InputDecoration(labelText: 'Поле 2'),
            onSaved: (val) => setState(() => _model.message.field2 = val)),
        Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: RaisedButton(
                onPressed: () {
                  final form = _formKey.currentState;
                  if (form.validate()) {
                    form.save();
                    _model.save();
                  }
                },
                child: Text('Сохранить'))),
      ]),
    );
  }
}
