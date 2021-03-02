import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffy_machine2_firebase_fluter/models/brew.dart';
import 'package:coffy_machine2_firebase_fluter/models/user.dart';

class DatabaseServie {

  final String uid;
  DatabaseServie({this.uid});

  //collection reference
  final CollectionReference brewCollection = FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strenght)  async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strenght': strenght
    });
  }

  //brew list from snaphot
  List<Brew> _brewListFromSnaphot(QuerySnapshot snapshot) {//tworze se liste mojej klasy Brew, gdzie mam tylko cukier, moc, imie
    //robie to żeby wywalic niepotrzebne rzeczy, za pomocą QuerySnapshot (chyba) w json'ie pobieram informacje, które zwracam z tego, jako lista
    //zwracam ten jsonowy snapshot, odnoszę się do dockumentów, mapuję to przechodząc wszystko przez parametr mój o nazwie "doc", zwracam później
    // moja klase, której daję potrzebne paramatry jak ich nie ma to zera, i jak pisałem wszystko pod koniec dodaje to do listy
    return snapshot.docs.map((doc){
      return Brew(
        name: doc.data()['name'] ?? '',
        strenght: doc.data()['strenght'] ?? 0,
        sugars: doc.data()['sugars'] ?? '0',
      );
    }).toList();
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strenght: snapshot.data()['strenght'],
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnaphot);
  }

  //get user doc stream
  Stream<UserData>get userData {
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }
}