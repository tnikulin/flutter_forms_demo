import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/create_message_model.dart';
import 'package:flutter_form_demo/view/person_form_view.dart';
import 'package:flutter_form_demo/view/widget/checkbox_form_field.dart';
import 'package:flutter_form_demo/view/widget/datepicker_form_field.dart';
import 'package:flutter_form_demo/view/widget/dict_form_field.dart';
import 'package:flutter_form_demo/view/widget/input_text_form_field.dart';

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
          InputTextFormField(
              label: 'Сгенерированное поле',
              initialValue: widget.model.message.generatedField,
              readOnly: true),
          InputTextFormField(
              label: 'Поле 1',
              onSaved: (val) => widget.model.message.field1 = val,
              validator: (value) => value.isEmpty ? 'Заполните поле 1' : null),
          InputTextFormField(
              label: 'Поле 2',
              onSaved: (val) => widget.model.message.field2 = val),
          DictFormField(
            label: 'Справочное значение',
            onChanged: (val) => widget.model.message.dictionaryField = val,
            items: widget.model.dictItems,
            validator: (value) => value?.id == null ? 'Заполните поле' : null,
          ),
          CheckboxFormField(
            onSaved: (val) => widget.model.message.checkboxField = val,
          ),
          DatepickerFormField(
            initialValue: DateTime.now(),
            onSaved: (val) => widget.model.message.dateTimeField = val,
            validator: (DateTime value) {
              DateTime now = new DateTime.now();
              DateTime date = new DateTime(now.year, now.month, now.day);
              return value.isBefore(date)
                  ? 'Дата не может быть меньше текущей'
                  : null;
            },
          ),
          PersonFormView(
              label: 'Данные физлица 1', person: widget.model.message.person1),
          PersonFormView(
              label: 'Данные физлица 2', person: widget.model.message.person2),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                RaisedButton(
                    onPressed: loading ? null : onSuccessFormSubmit,
                    child: Text('Сохранить')),
                RaisedButton(
                    onPressed: loading ? null : onErrorFormSubmit,
                    child: Text('Сохранить с ошибкой')),
                RaisedButton(
                    onPressed:
                        loading ? null : () => _formKey.currentState.reset(),
                    child: Text('Очистить')),
              ])),
        ]),
      )
    ]);
  }

  void onSuccessFormSubmit() {
    onFormSubmit();
  }

  void onErrorFormSubmit() {
    onFormSubmit(withError: true);
  }

  void onFormSubmit({bool withError = false}) {
    final form = _formKey.currentState;
    if (form.validate()) {
      setState(() {
        form.save();
        widget.model.save(withError).then((value) {
          setState(() {
            print('Форма успешно сохранена');
            print('новый ${widget.model.message.generatedField}');
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
