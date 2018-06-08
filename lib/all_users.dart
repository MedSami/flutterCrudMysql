import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => new _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  var _isLoading = false;
  var data;
  var tof, name, ps, adress, phone;

  Future<String> _ShowDialog(String msg) async {
    return showDialog<String>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Info '),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(msg),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              _getData();
                },
            ),
          ],
        );
      },
    );
  }

  void _deletUser(var id) async {
    var url =
        "https://astringent-dents.000webhostapp.com/EConstat/FlutterTraining/DeleteUser.php";

    var response = await http.post(url, body: {"userid": id});
    if (response.statusCode == 200) {
      _ShowDialog("Deleted");
    } else {
      _ShowDialog("Not Deleted");
    }
    //print(_adresseController.text);
  }

  _getData() async {
    final url =
        "https://astringent-dents.000webhostapp.com/EConstat/FlutterTraining/SelectAllUsers.php";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final users = map["result"];

      setState(() {
        _isLoading = true;
        this.data = users;
        print(data);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        body: new Center(
          child: !_isLoading
              ? new CircularProgressIndicator()
              : new ListView.builder(
                  itemCount: this.data != null ? this.data.length : 0,
                  itemBuilder: (context, i) {
                    final v = this.data[i];
                    return new Card(
                      child: new FlatButton(
                        child: new Column(children: <Widget>[
                          Row(
                            children: <Widget>[
                              new CircleAvatar(
                                minRadius: 50.0,
                                backgroundColor: Colors.blue.shade50,
                                child: new Text(v["gender"]),
                              ),
                              Column(
                                children: <Widget>[
                                  new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(v["username"],
                                        style: new TextStyle(
                                            fontSize: 24.0,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(v["first_name"],
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(v["last_name"],
                                        style: new TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ]),
                        onPressed: () {
                          print(v["user_id"]);
                          _deletUser(v["user_id"]);
                        },
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}
