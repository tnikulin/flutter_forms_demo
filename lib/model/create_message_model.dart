import 'dart:async';

import 'package:flutter_form_demo/model/base_model.dart';
import 'package:flutter_form_demo/model/entity/dictionary.dart';
import 'package:flutter_form_demo/model/entity/message.dart';
import 'package:uuid/uuid.dart';

class CreateMessageModel extends BaseModel {
  var dictItems = [
    Dictionary(null, ''),
    Dictionary(1, 'Значение 1'),
    Dictionary(2, 'Значение 2'),
  ];

  var message = Message();
  MessageCreationStatus messageCreationStatus;

  save(bool withError, {Function() onSuccess}) {
    messageCreationStatus = null;
    wait(() async {
      try {
        final uuid = Uuid().v4();
        message.generatedField = uuid;
        await Future.delayed(Duration(seconds: 1), () => doSave(withError));
        messageCreationStatus = MessageCreationStatus(
            alertMessage: 'Сообщение успешно сохранено, id = $uuid');
        if (onSuccess != null) onSuccess();
      } catch (e) {
        messageCreationStatus = MessageCreationStatus(
            alertMessage: 'Ошибка сохранения сообщения: $e', error: true);
      }
    });
  }

  doSave(bool withError) {
    if (withError) {
      throw Exception('Тестовая ошибка');
    } else {
      print('Сообщение отправлено: ${message.toString()}');
    }
  }
}

class MessageCreationStatus {
  String alertMessage;
  final bool error;

  MessageCreationStatus({this.alertMessage, this.error = false});
}
