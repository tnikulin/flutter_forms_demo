import 'package:flutter_form_demo/model/message.dart';

class CreateMessageModel {

  var message = Message();

  save() {
    print('Сообщение: ${message.field1} ${message.field2}');
  }
}