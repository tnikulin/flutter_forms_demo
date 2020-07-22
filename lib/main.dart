import 'package:flutter/material.dart';
import 'package:flutter_form_demo/view/create_message_form_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Вызван метод MyApp#build');
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
            appBar: AppBar(title: Text('Profile')),
            body: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Builder(
                    builder: (context) =>
                        ListView(children: [CreateMessageFormView()])))));
  }
}
