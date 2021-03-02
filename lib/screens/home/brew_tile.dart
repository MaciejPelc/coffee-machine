import 'package:flutter/material.dart';
import 'package:coffy_machine2_firebase_fluter/models/brew.dart';

class BrewTile extends StatelessWidget {

  final Brew brew;
  BrewTile({this.brew});// przenosze info z tamtego gówna "brew_list" tutaj, i tutaj pobiera dane do tego gówna

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),//left top right bottom
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.brown[brew.strenght],
              backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(brew.name),
          subtitle: Text('Takes ${brew.sugars} sugars(s)'),
        ),
      ),
    );
  }
}