import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeMaterial(),
    );
  }
}

class HomeMaterial extends StatefulWidget {
  @override
  _HomeMaterialState createState() => _HomeMaterialState();
}

class _HomeMaterialState extends State<HomeMaterial> {
  final _formKey = GlobalKey<FormState>();
  final _user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: Container(
            padding:
            const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            decoration:
                            InputDecoration(labelText: 'First name'),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your first name';
                              }
                            },
                            onSaved: (val) =>
                                setState(() => _user.firstName = val),
                          ),
                          TextFormField(
                              decoration:
                              InputDecoration(labelText: 'Last name'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter your last name.';
                                }
                              },
                              onSaved: (val) =>
                                  setState(() => _user.lastName = val)),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Subscribe'),
                          ),
                          SwitchListTile(
                              title: const Text('Monthly Newsletter'),
                              value: _user.newsletter,
                              onChanged: (bool val) =>
                                  setState(() => _user.newsletter = val)),
                          Container(
                            padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                            child: Text('Interests'),
                          ),
                          CheckboxListTile(
                              title: const Text('Cooking'),
                              value: _user.passions[User.PassionCooking],
                              onChanged: (val) {
                                setState(() =>
                                _user.passions[User.PassionCooking] = val);
                              }),
                          CheckboxListTile(
                              title: const Text('Traveling'),
                              value: _user.passions[User.PassionTraveling],
                              onChanged: (val) {
                                setState(() => _user
                                    .passions[User.PassionTraveling] = val);
                              }),
                          CheckboxListTile(
                              title: const Text('Hiking'),
                              value: _user.passions[User.PassionHiking],
                              onChanged: (val) {
                                setState(() =>
                                _user.passions[User.PassionHiking] = val);
                              }),
//                          new FormField(
//                            builder: (FormFieldState state) {
//                              return InputDecorator(
//                                decoration: InputDecoration(
//                                  icon: const Icon(Icons.color_lens),
//                                  labelText: 'Color',
//                                ),
//                                isEmpty: _user.gender == '',
//                                child: new DropdownButtonHideUnderline(
//                                  child: new DropdownButton(
//                                    value: _user.gender,
//                                    isDense: true,
//                                    onChanged: (String newValue) {
//                                      setState(() {
//                                        _user.gender = newValue;
//                                        state.didChange(newValue);
//                                      });
//                                    },
//                                    items: User.genders.map((String value) {
//                                      return new DropdownMenuItem(
//                                        value: value,
//                                        child: new Text(value),
//                                      );
//                                    }).toList(),
//                                  ),
//                                ),
//                              );
//                            },
//                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 16.0),
                              child: RaisedButton(
                                  onPressed: () {
                                    final form = _formKey.currentState;
                                    if (form.validate()) {
                                      form.save();
                                      _user.save();
                                      _showDialog(context);
                                    }
                                  },
                                  child: Text('Save'))),
                        ])))));
  }

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }
}

class User {
  static const String PassionCooking = 'cooking';
  static const String PassionHiking = 'hiking';
  static const String PassionTraveling = 'traveling';
  static const List<String> genders = ['male', 'female'];

  String firstName = '';
  String lastName = '';
  String gender = '';
  Map passions = {
    PassionCooking: false,
    PassionHiking: false,
    PassionTraveling: false
  };
  bool newsletter = false;
  save() {
    print('saving user using a web service');
  }
}