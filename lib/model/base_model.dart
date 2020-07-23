import 'package:flutter/widgets.dart';

/// Статус модели:
///  - notInitialized - данные модели не инициализированы.
///  - buzy - модель ожидает заверщения операции.
///  - ready - данные модели готовы к использованию.
///  - error - при получении данных модели произошла ошибка.
enum Status { notInitialized, buzy, ready, error }

/// Модель, поддерживающая управление собственным статусом.
///
/// Может находиться в одном из четырех статусов, определенных в [Status]. Сразу
/// после создания находится в статусе notInitialized.
///
/// При любом изменении статуса оповещает связанный виджет BaseView.
abstract class BaseModel extends ChangeNotifier {
  Status status = Status.notInitialized;
  var exception;

  /// Выполняет инициализацию модели.
  ///
  /// Метод вызывается связанным с данной моделью виджетом BaseView при его
  /// попадании в дерево виджетов. На время инициализации модель переходит
  /// в статусе buzy, по окончании - в статус ready при успешной инициализации,
  /// в статус error - при ошибке инициализации.
  void initModel() {
//    print('Вызван метод BaseModel#initModel');
    if (status == Status.notInitialized) {
      wait(() => init());
    }
  }

  /// Выполняет действия, необходимые для инициализации модели.
  ///
  /// Переопределяется в наследниках по необходимости.
  void init() {}

  /// Метод для обертки операций, требующих ожидания получения результата.
  ///
  /// На время ожидания завершения операции переводит модель в статус buzy,
  /// по окончании - в статус ready при успешном выполнении операции,
  /// в статус error - при возникновении ошибки.
  void wait(Function() action) {
    status = Status.buzy;
    notifyListeners();

    Future.value(action()).then((value) {
      status = Status.ready;
      notifyListeners();
    }).catchError((exception) {
      status = Status.error;
      this.exception = exception;
      notifyListeners();
    });
  }

  bool get busy => status == Status.buzy;
}
