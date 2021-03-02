class TheUser {

  final String uid;//to chyba umożliwia istnienie bez obiektu klasy

  TheUser( {this.uid}){}

}

class UserData {
  final String uid;
  final String name;
  final String sugars;
  final int strenght;

  UserData({this.uid, this.sugars, this.strenght, this.name});
}