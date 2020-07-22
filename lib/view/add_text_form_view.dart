import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/create_message_model.dart';
import 'package:flutter_form_demo/view/person_form_view.dart';
import 'package:flutter_form_demo/view/widget/checkbox_form_field.dart';
import 'package:flutter_form_demo/view/widget/datepicker_form_field.dart';
import 'package:flutter_form_demo/view/widget/dict_form_field.dart';
import 'package:flutter_form_demo/view/widget/input_table_form_field.dart';
import 'package:flutter_form_demo/view/widget/input_text_form_field.dart';

class AddTextFormView extends StatefulWidget {

  final Function(String) onSaved;

  const AddTextFormView({Key key, this.onSaved}) : super(key: key);

  @override
  _AddTextFormViewState createState() {
    return _AddTextFormViewState();
  }
}

class _AddTextFormViewState extends State<AddTextFormView> {
  String textMessage = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        key: _formKey,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          InputTextFormField(
              label: 'Поле 1',
              onSaved: widget.onSaved),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                RaisedButton(
                    onPressed: onFormSubmit,
                    child: Text('Сохранить')),
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
        Navigator.of(context).pop();
      });
    }
  }
}
