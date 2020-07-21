import 'package:flutter_form_demo/model/base_model.dart';
import 'package:flutter_form_demo/model/message.dart';

class CreateMessageModel extends BaseModel {
  var message = Message();
  var alert = '';

  save() {
    alert = 'Сохранено сообщение: ${message.field1} ${message.field2}';
    notifyListeners();
  }
}