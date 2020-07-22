import 'package:flutter/material.dart';

/// Form field для работы с списковыми данными
class InputTableFormField<T> extends FormField<List<T>> {
  InputTableFormField({
    List<DataColumn> columns,
    List<DataCell> Function(T) cellsBuilder,
    List<Widget> Function(T) formFieldsBuilder,
    T Function() newItemBuilder,
    label,
    FormFieldSetter<List<T>> onSaved,
    FormFieldValidator<List<T>> validator,
    List<T> initialValue,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue = [],
          builder: (FormFieldState<List<T>> state) =>
              InputTableFormFieldBuilder<T>(
            label: label,
            state: state,
            columns: columns,
            cellsBuilder: cellsBuilder,
            newItemBuilder: newItemBuilder,
            formFieldsBuilder: formFieldsBuilder,
          ),
        );
}

/// Построитель form field для работы с списковыми данными
class InputTableFormFieldBuilder<T> extends StatelessWidget {
  final String label;
  final FormFieldState<List<T>> state;
  final List<DataColumn> columns;
  final List<DataCell> Function(T) cellsBuilder;
  final T Function() newItemBuilder;
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
                            _onAdd(context, state, formFieldsBuilder);
                          })))),
              DataTable(
                columns: columns,
                rows: state.value
                    .map((item) => DataRow(cells: cellsBuilder(item)))
                    .toList(),
              )
            ])));
  }

  _onAdd(BuildContext context, FormFieldState<List<T>> state,
      List<Widget> Function(T) formFieldsBuilder) {
    T newItem = newItemBuilder();
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Добавить значение'),
            content: SingleChildScrollView(
              child: AddItemView<T>(
                  formFieldsBuilder: formFieldsBuilder, newItem: newItem),
            ));
      },
    ).then((value) {
      state.value.add(newItem);
      state.didChange(state.value);
    });
  }
}

/// View для добавления новой записи в таблицу
class AddItemView<T> extends StatefulWidget {
  final List<Widget> Function(T) formFieldsBuilder;
  final T newItem;

  const AddItemView({Key key, this.formFieldsBuilder, this.newItem})
      : super(key: key);

  @override
  _AddItemViewState<T> createState() {
    return _AddItemViewState<T>();
  }
}

class _AddItemViewState<T> extends State<AddItemView<T>> {
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
