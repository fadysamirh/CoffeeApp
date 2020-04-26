import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/screens/home/brew_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();



  @override
  Widget build(BuildContext context) {

    void _ShowSettingsPanel(){
      showModalBottomSheet(context: context,builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brewStream,
      child: Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          title: Text('Coffee Joint'),
          elevation: 0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              onPressed: () async {
                await _auth.signOut();
              },
              label: Text('Log out'),
            ),
            FlatButton.icon(
              onPressed: (){
                _ShowSettingsPanel();
              },
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            ),
          ],
          backgroundColor: Colors.brown[400],
        ),
        body: Container(
          child: BrewList(),
          decoration: BoxDecoration(
            image: DecorationImage(
              image:AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
          ),
      ),
    );
  }
}
