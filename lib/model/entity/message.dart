import 'package:flutter_form_demo/model/entity/dictionary.dart';

class Message {
  String field1;
  String field2;
  String generatedField;
  Dictionary dictionaryField;

  @override
  String toString() {
    return 'Message{field1: $field1, field2: $field2, generatedField: $generatedField, dictionaryField: ${dictionaryField.id}}';
  }
}