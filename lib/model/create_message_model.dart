import 'package:flutter_form_demo/model/entity/dictionary.dart';
import 'package:flutter_form_demo/model/entity/message.dart';

class CreateMessageModel {
  var dictItems = [
    Dictionary(null, ''),
    Dictionary(1, 'Значение 1'),
    Dictionary(2, 'Значение 2'),
  ];

  var message = Message();

  Future<void> save() {
    print('Вызван метод CreateMessageModel#save');
    return Future.delayed(Duration(seconds: 1),
        () => print('Сообщение отправлено: ${message.toString()}'));
//    return Future.delayed(
//        Duration(seconds: 1), () => throw Exception('Сервер недоступен'));
  }
}
