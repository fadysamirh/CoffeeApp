import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;

  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection=Firestore.instance.collection('brews');

  //updating user date

  Future updateUserData(String name, String sugars, int strength)async{

    return await brewCollection.document(uid).setData({
      'sugars':sugars,
      'strength':strength,
      'name': name
    });

  }

  //stream for changes to documents

  Stream<List<Brew>> get brewStream{
    return brewCollection.snapshots().map(_snapshotToBrewList);
  }

  //brewlist from a snapshot
  List<Brew> _snapshotToBrewList(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(name: doc.data['name']?? '', sugar: doc.data['sugars']?? '0', strength: doc.data['strength']??0);
    }).toList();
  }

  //ger user doc stream

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength']
    );
  }
}