import 'package:flutter_form_demo/model/entity/dictionary.dart';
import 'package:flutter_form_demo/model/entity/document.dart';
import 'package:flutter_form_demo/model/entity/person.dart';

class Message {
  String field1;
  String field2;
  String generatedField;
  Dictionary dictionaryField;
  bool checkboxField;
  DateTime dateTimeField;
  Person person1 = Person();
  Person person2 = Person();
  List<Document> documents = [];
  List<String> strings = [];

  @override
  String toString() {
    return 'Message{field1: $field1, field2: $field2, '
        'generatedField: $generatedField, dictionaryField: ${dictionaryField?.id}, '
        'checkboxField: $checkboxField}, dateTimeField: $dateTimeField, person1: $person1, '
        'person2: $person2, listField: $documents, strings: $strings';
  }
}
