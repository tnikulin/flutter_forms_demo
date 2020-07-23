import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/base_model.dart';
import 'package:provider/provider.dart';

/// Виджет для моделей, расширяющих BaseModel.
///
/// Виджет состоит из каркаса и содержимого, для построения которого используются
/// различные функции в зависимости от статуса модели.
///
/// Каркас не подписан на изменения модели, содержимое - подписано.
///
/// После создания вызывает метод инициализации связанной с виджетом модели
/// BaseModel.initModel
class BaseView<T extends BaseModel> extends StatefulWidget {
  final T model;
  final Widget Function(BuildContext ctx, T model, Widget child) layoutBuilder;
  final Widget Function(BuildContext ctx, T model) contentBuilder;
  final Widget Function(BuildContext ctx, T model) errorBuilder;
  final Widget Function(BuildContext ctx, T model) waitingBuilder;

  /// Конструктор.
  ///
  /// @param model модель, расширяющая BaseModel.
  /// @param layoutBuilder функция построения каркаса виджета. В качестве
  ///        параметров принимает контекст, модель и содержимое виджета.
  ///        Если данная функция не определена, содержимое виджета отрисовывается
  ///        напрямую.
  /// @param contentBuilder функция построения содержимого виджета при статусе
  ///        модели Status.ready.
  /// @param errorBuilder функция построения содержимого виджета при статусе
  ///        модели Status.error. Если параметр не определен, отрисовывается
  ///        сообщение об ошибке.
  /// @param waitingBuilder функция построения содержимого виджета при статусе
  ///        модели Status.buzy. Если параметр не определен, отрисовывается
  ///        значок ожидания.
  BaseView(
      {@required this.model,
      this.layoutBuilder,
      @required this.contentBuilder,
      this.errorBuilder,
      this.waitingBuilder});

  @override
  _BaseViewState<T> createState() {
//    print('Вызван метод BaseView#createState');
    return _BaseViewState<T>();
  }
}

class _BaseViewState<T extends BaseModel> extends State<BaseView<T>> {
  @override
  void initState() {
//    print('Вызван метод _BaseViewState#initState');
    widget.model.initModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    print('Вызван метод _BaseViewState#build');
    return ChangeNotifierProvider<T>.value(
        value: widget.model, child: _buildView());
  }

  Widget _buildView() {
    Widget content = Consumer<T>(
        builder: (context, model, _) => _buildContent(context, model));

    return Builder(
        builder: (context) => widget.layoutBuilder != null
            ? widget.layoutBuilder(
                context, Provider.of<T>(context, listen: false), content)
            : _defaultLayoutBuilder(content));
  }

  Widget _buildContent(BuildContext context, T model) {
    var status = model.status;
    switch (status) {
      case Status.ready:
        return widget.contentBuilder(context, model);
      case Status.buzy:
        return widget.waitingBuilder != null
            ? widget.waitingBuilder(context, model)
            : _defaultWaitingBuilder(context, model);
      case Status.error:
        return widget.errorBuilder != null
            ? widget.errorBuilder(context, model)
            : _defaultErrorBuilder(context, model);
      case Status.notInitialized:
        return Text('Модель не инициализирована',
            style: TextStyle(fontSize: 14));
      default:
        throw Exception('Статус $status не поддерживается');
    }
  }

  Widget _defaultLayoutBuilder(Widget content) => content;

  Widget _defaultErrorBuilder(BuildContext _, T model) => Center(
      child: Container(
          padding: EdgeInsets.all(5),
          child: Text('Произошла ошибка: ${model.exception}',
              style: TextStyle(fontSize: 14),
              textDirection: TextDirection.ltr)));

  Widget _defaultWaitingBuilder(BuildContext context, T model) => Center(
      child: Container(
          padding: EdgeInsets.all(5),
          width: 40,
          height: 40,
          child: CircularProgressIndicator()));
}
