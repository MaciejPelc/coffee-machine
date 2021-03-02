import 'package:coffy_machine2_firebase_fluter/models/user.dart';
import 'package:coffy_machine2_firebase_fluter/screens/wrapper.dart';
import 'package:coffy_machine2_firebase_fluter/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<TheUser>.value(//specyfikujemy jaki stream słuchamy "TheUser"
      value: AuthService().user,//podobno słucha i reaguje na zmiany
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
