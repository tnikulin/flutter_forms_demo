import 'package:flutter/material.dart';

// TODO tn in work
class InputTextFormField2 extends StatefulWidget {
  final String label;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String initialValue;
  final bool readOnly;


  const InputTextFormField2({
    this.label,
    this.onSaved,
    this.validator,
    this.initialValue,
    this.readOnly = false,
  });

  @override
  State<StatefulWidget> createState() {
    return ITState();
  }
}

class ITState extends State<InputTextFormField2> {

  var controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: widget.label),
      validator: widget.validator,
      readOnly: widget.readOnly,
      enabled: !widget.readOnly,
      onSaved: widget.onSaved,
      controller: controller,
    );
  }
}