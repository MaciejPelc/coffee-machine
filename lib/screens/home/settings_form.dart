import 'package:coffy_machine2_firebase_fluter/models/user.dart';
import 'package:coffy_machine2_firebase_fluter/services/database.dart';
import 'package:coffy_machine2_firebase_fluter/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffy_machine2_firebase_fluter/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {

  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0','1','2','3','4'];

  //form values
  String _currentName;
  String _currentSugars;
  int _currentStrengh;



  @override
  Widget build(BuildContext context){

  final uuser = Provider.of<TheUser>(context);

  return StreamBuilder<UserData>(//userData to to co będzie nam zwracane, lol
      stream: DatabaseServie(uid: uuser.uid).userData,
      builder: (context, snapshot) {//ten snapshot to referencja do snapshota zchodzącego ze streamu (co kurwa?), to nie snapshot z firebasa
        if(snapshot.hasData){

          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text(
                  'Update your brew settings.',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val.isEmpty ? 'Please enter a name' : null,//czy val ma wartość?
                  onChanged: (val) => setState(() => _currentName = val),//gdy wystąpi zmiana, zaktualizuj imię
                ),
                SizedBox(height: 20,),
                //dropdown
                DropdownButtonFormField(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? userData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val)
                ),
                Slider(
                  value: (_currentStrengh ?? userData.strenght).toDouble(),
                  activeColor: Colors.brown[_currentStrengh ?? userData.strenght],
                  inactiveColor: Colors.brown[_currentStrengh ?? userData.strenght],
                  min: 100.0,
                  max: 900.0,
                  divisions: 8,
                  onChanged: (val) =>setState(() => _currentStrengh = val.round()),
                ),
                //slider
                RaisedButton(
                  color: Colors.pink[400],
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      await DatabaseServie(uid: uuser.uid).updateUserData(
                          _currentSugars ?? userData.sugars,
                        _currentName ?? userData.name,
                        _currentStrengh ?? userData.strenght,
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }

      }
    );
  }
}
