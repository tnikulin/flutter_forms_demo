import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/create_message_model.dart';
import 'package:flutter_form_demo/view/widget/input_text.dart';

class CreateMessageFormView extends StatefulWidget {
  final CreateMessageModel model = CreateMessageModel();

  @override
  _CreateMessageFormViewState createState() {
    print('Вызван метод CreateMessageFormView#createState');
    return _CreateMessageFormViewState();
  }
}

class _CreateMessageFormViewState extends State<CreateMessageFormView> {
  String textMessage = '';
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print('Вызван метод _CreateMessageFormViewState#build');
    return Column(children: [
      Text(textMessage),
      Form(
        key: _formKey,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          InputText(
              label: 'Сгенерированное поле',
              initialValue: 'Сгенерированное значение',
              onSaved: (val) => widget.model.message.generatedField = val,
              readOnly: true),
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
              child: Column(children: [
                RaisedButton(
                    onPressed: loading ? null : onFormSubmit,
                    child: Text('Сохранить')),
                RaisedButton(
                    onPressed: loading
                        ? null
                        : () {
                            final form = _formKey.currentState;
                            form.reset();
                          },
                    child: Text('Очистить')),
              ])),
        ]),
      )
    ]);
  }

  void onFormSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        widget.model.save().then((value) {
          setState(() {
            textMessage = 'Сообщение отправлено';
            form.reset();
            loading = false;
          });
        }).catchError((exception) {
          setState(() {
            textMessage = 'Ошибка сохранения формы: ${exception.toString()}';
            loading = false;
          });
        });
        loading = true;
      });
    }
  }
}
