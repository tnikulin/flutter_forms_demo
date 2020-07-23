import 'package:flutter_form_demo/model/entity/dictionary.dart';
import 'package:flutter_form_demo/model/entity/message.dart';
import 'package:uuid/uuid.dart';

class CreateMessageModel {
  var dictItems = [
    Dictionary(null, ''),
    Dictionary(1, 'Значение 1'),
    Dictionary(2, 'Значение 2'),
  ];
  var message = Message();

  CreateMessageModel() {
    initMessage();
  }

  Future<void> save(bool withError) {
//    print('Вызван метод CreateMessageModel#save');
    if (withError) {
      return Future.delayed(
          Duration(seconds: 1), () => throw Exception('Сервер недоступен'));
    } else {
      return Future.delayed(Duration(seconds: 1), () {
        print('Сообщение отправлено: ${message.toString()}');
        initMessage();
      });
    }
  }

  void initMessage() {
    var uuid = Uuid();
    message.generatedField = uuid.v1();
  }
}
