import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatepickerFormField extends FormField<DateTime> {
  static final defaultDateFormat = DateFormat('dd.MM.yyyy');

  DatepickerFormField(
      {FormFieldSetter<DateTime> onSaved,
      FormFieldValidator<DateTime> validator,
      DateTime initialValue = null,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<DateTime> state) {
              return Builder(
                  builder: (context) => Column(children: [
                        TextFormField(
                            key: UniqueKey(),
                            readOnly: true,
                            initialValue: state.value != null
                                ? defaultDateFormat.format(state.value)
                                : null,
                            onTap: () {
                              _selectDate(context, state.value).then((value) {
                                print('Состояние изм');
                                state.didChange(value);
                              });
                            },
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(3.0),
                                labelStyle: TextStyle(fontSize: 15.0),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(width: 0.5)),
                                suffixIcon: Icon(Icons.calendar_today),
                                suffixIconConstraints:
                                    BoxConstraints(maxHeight: 10),
                                labelText: 'Поле ввода даты')
                            ),
                        state.hasError
                            ? Text(
                                state.errorText,
                                style: TextStyle(color: Colors.red),
                              )
                            : Container()
                      ]));
            });

  static Future<DateTime> _selectDate(
      BuildContext context, DateTime initialDate) {
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2200),
    );
  }
}
