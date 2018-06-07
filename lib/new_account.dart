import 'package:econstat/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  final ThemeData _CeTheme = _buildTheme();
  static ThemeData _buildTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      accentColor: CeBrown900,
      primaryColor: CePink100,
      buttonColor: CePink100,
      scaffoldBackgroundColor: CeBackgroundWhite,
      cardColor: CeBackgroundWhite,
      textSelectionColor: CePink100,
      errorColor: CeErrorRed,
      //TODO: Add the text themes (103)
      //TODO: Add the icon themes (103)
      //TODO: Decorate the inputs (103)
    );
  }

  void onCreatedAccount() {
    var alert = new AlertDialog(
      title: new Text('Info'),
      content: new SingleChildScrollView(
        child: new ListBody(
          children: <Widget>[
            new Text('You have created a new Account.'),
          ],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text('Ok'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
    showDialog(context: context, child: alert);
  }

  var _usernameController = new TextEditingController();
  var _firstnameController = new TextEditingController();
  var _lastnameController = new TextEditingController();
  var _genderController = new TextEditingController();
  var _passwordController = new TextEditingController();
  void _addData() {
    var url =
        "https://astringent-dents.000webhostapp.com/EConstat/FlutterTraining/NewUser.php";

    http.post(url, body: {
      "username": _usernameController.text,
      "firstname": _firstnameController.text,
      "gender": _genderController.text,
      "lastname": _lastnameController.text,
      "password": _passwordController.text
    });
    onCreatedAccount();
    //print(_adresseController.text);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: new Padding(
        padding: const EdgeInsets.only(
            left: 16.0, top: 30.0, right: 16.0, bottom: 16.0),
        child: ListView(
          children: <Widget>[
            new ListTile(
              leading: const Icon(Icons.person),
              title: TextField(
                decoration: InputDecoration(
                    labelText: "UserName : ", hintText: " User Name "),
                controller: _usernameController,
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.person),
              title: TextField(
                decoration: InputDecoration(
                    labelText: "First Name : ", hintText: " First Name "),
                controller: _firstnameController,
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.person),
              title: TextField(
                decoration: InputDecoration(
                    labelText: "Gender : ", hintText: " Gender "),
                controller: _genderController,
              ),
            ),
            new ListTile(
              leading: const Icon(Icons.remove_red_eye),
              title: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    labelText: "Password : ", hintText: "Password "),
                controller: _passwordController,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            new ButtonTheme.bar(
              // make buttons use the appropriate styles for cards
              child: new ButtonBar(
                children: <Widget>[
                  new RaisedButton.icon(
                    label: Text(
                      'Back ',
                      textScaleFactor: 2.0,
                    ),
                    icon: Icon(Icons.cancel),
                    onPressed: () {
                      Navigator.of(context).pop();
                      //_UpdateData(widget.idUser, _nom.text, _pseudo.text, _prenom.text, _numTel.text);
                    },
                  ),
                  new RaisedButton.icon(
                    onPressed: () {
                      _addData();
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "Register",
                      textScaleFactor: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
