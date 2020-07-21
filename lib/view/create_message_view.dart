import 'package:flutter/material.dart';
import 'package:flutter_form_demo/model/create_message_model.dart';
import 'package:flutter_form_demo/view/base_view.dart';
import 'package:flutter_form_demo/view/create_message_form_view.dart';

class CreateMessageView extends StatelessWidget {
  final _model = CreateMessageModel();

  @override
  Widget build(BuildContext context) {
    print('Вызван метод CreateMessageView#build');
    return BaseView<CreateMessageModel>(
      model: _model,
      layoutBuilder: _buildLayout,
      contentBuilder: _buildContent,
//      waitingBuilder: _buildContent
    );
  }

  Widget _buildLayout(
      BuildContext context, CreateMessageModel model, Widget child) {
    print('Вызван метод CreateMessageView#_buildLayout');
    return Container(child: child);
  }

  Widget _buildContent(BuildContext context, CreateMessageModel model) {
    print('Вызван метод CreateMessageView#_buildContent');
    return Column(children: [
      Text(_model.alert),
      CreateMessageFormView(model: _model)
    ]);
  }
}