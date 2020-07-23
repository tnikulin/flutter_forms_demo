import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/create_message_model.dart';
import 'package:flutter_form_demo/model/entity/document.dart';
import 'package:flutter_form_demo/view/base_view.dart';
import 'package:flutter_form_demo/view/person_form_view.dart';
import 'package:flutter_form_demo/view/widget/checkbox_form_field.dart';
import 'package:flutter_form_demo/view/widget/datepicker_form_field.dart';
import 'package:flutter_form_demo/view/widget/dict_form_field.dart';
import 'package:flutter_form_demo/view/widget/input_table_form_field.dart';
import 'package:flutter_form_demo/view/widget/input_text_form_field.dart';

class CreateMessageFormView extends StatefulWidget {
  @override
  _CreateMessageFormViewState createState() {
//    print('Вызван метод CreateMessageFormView#createState');
    return _CreateMessageFormViewState();
  }
}

class _CreateMessageFormViewState extends State<CreateMessageFormView> {
  final CreateMessageModel model = CreateMessageModel();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseView<CreateMessageModel>(
        model: model,
        contentBuilder: buildContent,
        errorBuilder: buildContent,
        waitingBuilder: buildContent);
  }

  Widget _alertMessage() {
    return model.messageCreationStatus != null
        ? Text(model.messageCreationStatus.alertMessage,
            style: TextStyle(
                color: model.messageCreationStatus.error
                    ? Colors.red
                    : Colors.blueAccent))
        : Text('');
  }

  Widget buildContent(BuildContext context, CreateMessageModel model) {
//    print('Вызван метод _CreateMessageFormViewState#build');
    return Column(children: [
      _alertMessage(),
      Form(
        key: _formKey,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          InputTextFormField(
              label: 'Поле 1',
              onSaved: (val) => model.message.field1 = val,
              validator: (value) => value.isEmpty ? 'Заполните поле 1' : null),
          InputTextFormField(
              label: 'Поле 2', onSaved: (val) => model.message.field2 = val),
          DictFormField(
            label: 'Справочное значение',
            onChanged: (val) => model.message.dictionaryField = val,
            items: model.dictItems,
            validator: (value) => value?.id == null ? 'Заполните поле' : null,
          ),
          CheckboxFormField(
            onSaved: (val) => model.message.checkboxField = val,
          ),
          DatepickerFormField(
            initialValue: DateTime.now(),
            onSaved: (val) => model.message.dateTimeField = val,
            validator: (DateTime value) {
              DateTime now = new DateTime.now();
              DateTime date = new DateTime(now.year, now.month, now.day);
              return value.isBefore(date)
                  ? 'Дата не может быть меньше текущей'
                  : null;
            },
          ),
          PersonFormView(
              label: 'Данные физлица 1', person: model.message.person1),
          PersonFormView(
              label: 'Данные физлица 2', person: model.message.person2),
          _inputDocumentsTable(),
          _inputStringsTable(),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                RaisedButton(
                    onPressed: model.busy ? null : onSuccessFormSubmit,
                    child: Text('Сохранить')),
                RaisedButton(
                    onPressed: model.busy ? null : onErrorFormSubmit,
                    child: Text('Сохранить с ошибкой')),
                RaisedButton(
                    onPressed:
                        model.busy ? null : () => _formKey.currentState.reset(),
                    child: Text('Очистить')),
              ])),
        ]),
      )
    ]);
  }

  InputTableFormField<Document> _inputDocumentsTable() {
    return InputTableFormField<Document>(
      label: 'Документы',
      columns: [
        DataColumn(label: Text('Серия')),
        DataColumn(label: Text('Номер'))
      ],
      cellsBuilder: (document) =>
          [DataCell(Text(document.series)), DataCell(Text(document.number))],
      newItemBuilder: () => Document(),
      formFieldsBuilder: (document) {
        return [
          InputTextFormField(
              label: 'Серия', onSaved: (val) => document.series = val),
          InputTextFormField(
              label: 'Номер', onSaved: (val) => document.number = val),
        ];
      },
      onSaved: (val) => model.message.documents = val,
    );
  }

  /// Для добавления в таблице списка значений типа String приходится
  /// использовать класс-обертку StringWrapper, однако это касается только
  /// логики представления, не просачивается в модель и не лишает код
  /// типобезопасности
  InputTableFormField<StringWrapper> _inputStringsTable() {
    return InputTableFormField<StringWrapper>(
      label: 'Строки',
      columns: [DataColumn(label: Text('Значение'))],
      cellsBuilder: (wrapper) => [DataCell(Text(wrapper.value))],
      newItemBuilder: () => StringWrapper(),
      formFieldsBuilder: (wrapper) => [
        InputTextFormField(
            label: 'Значение', onSaved: (val) => wrapper.value = val),
      ],
      onSaved: (val) =>
          model.message.strings = val.map((wrapper) => wrapper.value).toList(),
    );
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
      form.save();
      model.save(withError, onSuccess: () => form.reset());
    }
  }
}

class StringWrapper {
  String value;
}
