import 'package:flutter_form_demo/model/base_model.dart';
import 'package:flutter_form_demo/model/message.dart';

class CreateMessageModel {
  var message = Message();

  Future<void> save() {
    print('Вызван метод CreateMessageModel#save');
    return Future.delayed(Duration(seconds: 3), () => print('Сообщение отправлено: ${message.toString()}'));
//    return Future.delayed(
//        Duration(seconds: 1), () => throw Exception('Сервер недоступен'));
  }
}
