import 'package:econstat/all_users.dart';
import 'package:econstat/profile.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SecondScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Second Page",
      theme: new ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.deepOrange,
      ),
      home: SecondPage(),
    );
  }
}

class SecondPage extends StatelessWidget {
  var idUser,username,firstname,lastname;
  SecondPage({Key key, this.idUser,this.firstname,this.lastname,this.username}) : super(key: key);

  _launchURL() async {
    const url = 'tel:27181132';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not make Call';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Second Screen"),
      ),
      drawer: new Drawer(
          child: new ListView(
        children: <Widget>[
          new DrawerHeader(
            child: new Row(
              children: <Widget>[
                new Expanded(
                  child: Row(
                    children: <Widget>[
                      new Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  "https://i.imgur.com/BoN9kdC.png")),
                        ),
                      ),
                      new Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: new Column(
                          children: <Widget>[
                            Text("User Name : ${this.username}"),
                            Text("First Name : ${this.firstname}"),
                            Text("Last Name : ${this.lastname}"),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          new ListTile(
            title: new Text('Your Profile'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Your Contract'),
            onTap: () {},
          ),
          new ListTile(
            title: new Text('Call Customer Service'),
            onTap: () {
              _launchURL();
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text('About Us'),
            onTap: () {},
          ),
        ],
      )),
      body: new Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                color: Theme.of(context).accentColor,
                minWidth: 170.0,
                onPressed: () {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new Profile(idUser: this.idUser),
                  );
                  Navigator.of(context).push(route);
                },
                child: Text("Profile"),
              ),
              MaterialButton(
                minWidth: 170.0,
                color: Theme.of(context).accentColor,
                onPressed: () {
                  var route = new MaterialPageRoute(
                    builder: (BuildContext context) => new AllUsers(),
                  );
                  Navigator.of(context).push(route);
                },
                child: Text("All Users"),
              ),
              MaterialButton(
                minWidth: 170.0,
                color: Theme.of(context).accentColor,
                onPressed: () {
                  _launchURL();
                },
                child: Text("Call Customer Service"),
              ),
              MaterialButton(
                minWidth: 170.0,
                color: Theme.of(context).accentColor,
                onPressed: () {},
                child: Text("Econstat"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
