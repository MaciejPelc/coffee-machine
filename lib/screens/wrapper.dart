import 'package:coffy_machine2_firebase_fluter/screens/authenticate/authenticate.dart';
import 'package:coffy_machine2_firebase_fluter/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:coffy_machine2_firebase_fluter/models/user.dart';

class Wrapper extends StatelessWidget {
  //String lol = "dupa sraka";//test

  @override
  Widget build(BuildContext context) {
    final uuser = Provider.of<TheUser>(context);//acess of data,
    //return either Home or Authenticate widget
    if(uuser == null){
      return Authenticate();
    }else
      return Home();
    }
  }
