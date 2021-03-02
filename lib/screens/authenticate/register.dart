import 'package:coffy_machine2_firebase_fluter/services/auth.dart';
import 'package:coffy_machine2_firebase_fluter/shared/constants.dart';
import 'package:coffy_machine2_firebase_fluter/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:coffy_machine2_firebase_fluter/screens/authenticate/sign_in.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  //text field state
  String email ='';
  String password ='';
  String error ='';
  bool loading = false;


  @override
  Widget build(BuildContext context) {
    return loading? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
                },
              icon: Icon(Icons.person),
              label: Text('Sign in'))
        ],
        backgroundColor: Colors.brown[600],
        elevation: 0.0,
        title: Text('Sign up to Coffe Machinge'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: 150,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.pink[900],
                  child: Text('Register',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()){//przechodzi przez wszystkie funkcje "validator" i sprawdza czy są nulle
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null){
                        setState(() {
                          error = 'please supply a valid email';
                          loading = false;
                        });
                      }//tu powinno być else i przekierowanie do Home(), ale tam słucha tego wszystkiego jakiś set state i on zmienia to
                      //przekierowując autoatycznie
                    }
                  },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
