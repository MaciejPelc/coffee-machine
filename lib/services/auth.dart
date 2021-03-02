import 'package:coffy_machine2_firebase_fluter/models/user.dart';
import 'package:coffy_machine2_firebase_fluter/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

//firabase auth

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on User(FirebaseUser = User)
  //z tego co kojarzę user taki normalny, z firebasa, ma za dużo elementów, więc tworzysz to
  //żeby móc pobrać tylko potrzebny element z usera, i wypluć to w podpowiednim miejscu
  TheUser _userFromFirebaseUser(User user) {
    return user != null ? TheUser(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<TheUser> get user {// to chyba nasłuchuje zmian w userze, dlatego jest w 'stream', tym samym, w potoku wszysko płynie
    return _auth.authStateChanges()
        .map((User user) => _userFromFirebaseUser(user)); //ta mapa i ta niżej robi to samo
        //.map(_userFromFirebaseUser);
  }


  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously(); //AuthResult = UserCredential
      User user = result.user; // FirebaseUser = User
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email & PASSWORD
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;// result.user ma w sobie mase nie potrzebnych rzeczy, ograniczamy go do naszej klasy, z jednym elementem
      return _userFromFirebaseUser(user);//w linijce wyżej wstawiamy to w usera firebaseowego, a teraz ten paramtetr do naszej klasy
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  //REGISTER WITH EMAIL & PASSWORD
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;// result.user ma w sobie mase nie potrzebnych rzeczy, ograniczamy go do naszej klasy, z jednym elementem
      //w linijce wyżej wstawiamy to w usera firebaseowego, a teraz ten paramtetr do naszej klasy

      //create a new document for the user with the uid
      await DatabaseServie(uid: user.uid).updateUserData('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    }catch(e) {
      print(e.toString());
      return null;
    }
  }

  //sing out
  Future signOutMyClass() async{
    try{// zastanawiałem się tutaj raz, jeżeli catch zwraca null, a w "wrapper" jak dostanę null, to zostaje on wylogowany
      //to czy jakbym dostał wyjątek, to czy by mnie wylogowało?
      //odpowiedź to nie, nie wyloguje, będzie po prostu błąd, bo uuser w raperze szuka providera, i to on musi być 'wynulowany'
      //tą komendą niżej
      return await _auth.signOut();//metoda z firebasa
    }catch(e){
      print(e.ToString());
      return null;
    }
  }
}
