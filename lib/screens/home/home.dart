import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffy_machine2_firebase_fluter/models/brew.dart';
import 'package:coffy_machine2_firebase_fluter/screens/home/settings_form.dart';
import 'package:coffy_machine2_firebase_fluter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:coffy_machine2_firebase_fluter/services/database.dart';
import 'package:provider/provider.dart';
import 'package:coffy_machine2_firebase_fluter/screens/home/brew_list.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
      });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseServie().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffy Machine'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[//akcje, to małe ikonki po prawej appbaru (wylogowywanie/ustawienia)
            FlatButton.icon(
                onPressed: () async{
                  await _auth.signOutMyClass();
                },
                icon: Icon(Icons.logout),
                label: Text('logout')),
            FlatButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () =>_showSettingsPanel(),
            )
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/coffee_bg.png'),
              fit: BoxFit.cover,
            )
          ),
            child: BrewList()
        ),
      ),
    );
  }
}
