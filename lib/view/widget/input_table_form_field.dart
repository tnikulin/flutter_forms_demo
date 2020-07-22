import 'package:flutter/material.dart';
import 'package:flutter_form_demo/view/add_text_form_view.dart';

class InputTableFormField extends FormField<List<String>> {
  final String label;

  InputTableFormField(
      {this.label,
      FormFieldSetter<List<String>> onSaved,
      FormFieldValidator<List<String>> validator,
      List<String> initialValue})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue = [],
            builder: (FormFieldState<List<String>> state) =>
                _build(label, state));

  static Widget _build(String label, FormFieldState<List<String>> state) {
    return Builder(
        builder: (context) => Container(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(children: [
              Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Align(
                      alignment: Alignment.topRight,
                      child: (IconButton(
                          icon: Icon(Icons.add),
                          tooltip: 'Добавить запись',
                          onPressed: () {
                            onAdd(context, state);
                          })))),
              _datatable(state.value, context)
            ])));
  }

  static DataTable _datatable(List<String> data, BuildContext context) {
    return DataTable(
//      key: UniqueKey(),
      columns: [DataColumn(label: Text('Данные'))],
      rows: data.map((item) => _row(context, item)).toList(),
    );
  }

  static DataRow _row(BuildContext context, String item) {
    return DataRow(cells: [DataCell(Text(item))]);
  }

  static onAdd(BuildContext context, FormFieldState<List<String>> state) {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Добавить значение'),
            content: SingleChildScrollView(
              child: AddTextFormView(onSaved: (val) => state.value.add(val)),
            ));
      },
    ).then((value) => {state.didChange(state.value)});
  }
}
