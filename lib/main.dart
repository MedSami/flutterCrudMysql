import 'package:econstat/new_account.dart';
import 'package:econstat/second_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'colors.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData _kShrineTheme = _buildTheme();

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Basic List',
      theme: _kShrineTheme,
      home: new MyHomePage(),
    );
  }

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
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _pseudoController = new TextEditingController();
  var _passwordController = new TextEditingController();
  var data;

  var _isSecured = true;
  @override
  Widget build(BuildContext context) {
    /**************** Get Login Connection && Data ************************/
    Future<String> getLogin(String pseudo) async {
      var response = await http.get(
          Uri.encodeFull(
              "https://astringent-dents.000webhostapp.com/EConstat/FlutterTraining/Login.php?PSEUDO=${pseudo}"),
          headers: {"Accept": "application/json"});

      print(response.body);
      setState(() {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson['result'];
      });
    }

    /*********************Alert Dialog Pseudo******************************/
    void onSignedInErrorPassword() {
      var alert = new AlertDialog(
        title: new Text("Pseudo Error"),
        content: new Text(
            "There was an Password error signing in. Please try again."),
      );
      showDialog(context: context, child: alert);
    }

    /*********************Alert Dialog Pseudo******************************/
    void onSignedInErrorPseudo() {
      var alert = new AlertDialog(
        title: new Text("Pseudo Error"),
        content:
            new Text("There was an Pseudo error signing in. Please try again."),
      );
      showDialog(context: context, child: alert);
    }

    /******************* Check Data ****************************/
    VerifData(String pseudo, String password, var datadb) {
      if (data[0]['username'] == pseudo) {
        if (data[0]['password'] == password) {
          // Navigator.of(context).pushNamed("/seconds");

          var route = new MaterialPageRoute(
            builder: (BuildContext context) =>
                new SecondScreen(idUser: data[0]['user_id']),
          );
          Navigator.of(context).push(route);
        } else {
          onSignedInErrorPassword();
        }
      } else {
        onSignedInErrorPseudo();
      }
    }

    /******************* LOGO ************************/
    var logo = new Center(
      child: new Container(
        width: 190.0,
        height: 190.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
          image: new DecorationImage(
              fit: BoxFit.fill,
              image: new NetworkImage("https://vignette.wikia.nocookie.net/flutter-butterfly-sanctuary/images/7/7f/FlutterLogo.PNG/revision/latest?cb=20131017172902")),
        ),
      ),
    );
    /*******************************************************/

    /****************** TextField Pseudo*******************************/
    var pseudo = new ListTile(
      leading: const Icon(Icons.person),
      title: TextFormField(
        decoration: InputDecoration(
            labelText: "your Pseudo",
            filled: true,
            hintText: "Write your Pseudo please",
            border: InputBorder.none),
        controller: _pseudoController,
      ),
    );

    /************************************************************/

    /******************** TextField Password ******************************/
    var password = new ListTile(
      leading: const Icon(Icons.remove_red_eye),
      title: TextField(
        decoration: InputDecoration(
            icon: new IconButton(
                icon: Icon(
                  Icons.remove_red_eye,
                ),
                onPressed: () {
                  setState(() {
                    _isSecured = !_isSecured;
                  });
                }),
            labelText: "your Password",
            hintText: "Write your Password please",
            border: InputBorder.none),
        obscureText: _isSecured,
        controller: _passwordController,
      ),
    );

    /****************************************************/
    /********************* Button Login****************************************/
    var createaccount = new Container(
      child: RaisedButton(
        child: const Text('Register'),
        color: Theme.of(context).accentColor,
        elevation: 8.0,
        splashColor: Colors.blueGrey,
        onPressed: () {
          var route = new MaterialPageRoute(
            builder: (BuildContext context) => new Register(),
          );
          Navigator.of(context).push(route);
        },
      ),
    );
/*************************************************/

    /********************* Button Login****************************************/
    var loginButton = new Container(
      child: RaisedButton(
        child: const Text('LogIn'),
        color: Theme.of(context).accentColor,
        elevation: 8.0,
        splashColor: Colors.blueGrey,
        onPressed: () {
          // Perform some action
          //SnackBar(content: Text("TEST SNACK BAR"),backgroundColor: Colors.deepOrange,);
          getLogin(_pseudoController.text);
          VerifData(_pseudoController.text, _passwordController.text, data);
        },
      ),
    );
/*************************************************/

    /********************Button Cancel ***********************/
    var cancelButton = new Container(
      child: FlatButton(
        child: const Text('Cancel'),
        onPressed: () {
          _passwordController.clear();
          _pseudoController.clear();
        },
      ),
    );

/***********************************************/

    return new Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: new ListView(
        children: <Widget>[
          SizedBox(
            height: 50.0,
          ),
          logo,
          SizedBox(
            height: 100.0,
          ),
          new Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: <Widget>[pseudo, password],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[cancelButton, loginButton, createaccount],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
