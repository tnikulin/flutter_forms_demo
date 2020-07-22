import 'package:flutter/material.dart';

class InputTableFormField<T> extends FormField<List<T>> {
  final String label;

  InputTableFormField(
      {List<DataColumn> columns,
      List<DataCell> Function(T) cellsBuilder,
      List<Widget> Function(T) formFieldsBuilder,
      T Function() newItemBuilder,
      this.label,
      FormFieldSetter<List<T>> onSaved,
      FormFieldValidator<List<T>> validator,
      List<T> initialValue})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue = [],
            builder: (FormFieldState<List<T>> state) =>
                InputTableFormFieldBuilder<T>(
                    formFieldsBuilder: formFieldsBuilder,
                    cellsBuilder: cellsBuilder,
                    newItemBuilder: newItemBuilder,
                    columns: columns,
                    label: label,
                    state: state));
}

class InputTableFormFieldBuilder<T> extends StatelessWidget {
  final FormFieldState<List<T>> state;
  final String label;
  final List<DataColumn> columns;
  final T Function() newItemBuilder;
  final List<DataCell> Function(T) cellsBuilder;
  final List<Widget> Function(T) formFieldsBuilder;

  const InputTableFormFieldBuilder(
      {Key key,
      this.state,
      this.label,
      this.columns,
      this.cellsBuilder,
      this.formFieldsBuilder,
      this.newItemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                            onAdd(context, state, formFieldsBuilder);
                          })))),
              _datatable(state.value, context)
            ])));
  }

  DataTable _datatable(List<T> data, BuildContext context) {
    return DataTable(
//      key: UniqueKey(),
      columns: columns,
      rows: data.map((item) => _row(context, item)).toList(),
    );
  }

  DataRow _row(BuildContext context, T item) {
    return DataRow(cells: cellsBuilder(item));
  }

  onAdd(BuildContext context, FormFieldState<List<T>> state,
      List<Widget> Function(T) formFieldsBuilder) {
    T newItem = newItemBuilder();
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Добавить значение'),
            content: SingleChildScrollView(
              child: AddFormView<T>(
                  formFieldsBuilder: formFieldsBuilder,
                  newItem: newItem),
            ));
      },
    ).then((value) {
      state.value.add(newItem);
      state.didChange(state.value);
    });
  }
}

class AddFormView<T> extends StatefulWidget {
  final List<Widget> Function(T) formFieldsBuilder;
  final T newItem;

  const AddFormView(
      {Key key, this.formFieldsBuilder, this.newItem})
      : super(key: key);

  @override
  _AddFormViewState<T> createState() {
    return _AddFormViewState<T>();
  }
}

class _AddFormViewState<T> extends State<AddFormView<T>> {
  String textMessage = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Form(
        key: _formKey,
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          ...widget.formFieldsBuilder(widget.newItem),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(children: [
                RaisedButton(onPressed: onFormSubmit, child: Text('Сохранить')),
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
