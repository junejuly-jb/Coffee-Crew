import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_maker/models/coffee.dart';
import 'package:coffee_maker/models/user.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference coffeeCollection =
      FirebaseFirestore.instance.collection('coffee');

  Future updateUserData(String sugars, String name, int strength) async {
    return await coffeeCollection
        .doc(uid)
        .set({'sugars': sugars, 'name': name, 'strength': strength});
  }

  //convert snapshot to own Cq  lass
  List<Coffee> _coffeeFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Coffee(
          name: doc.get('name') ?? '',
          sugars: doc.get('sugars') ?? '',
          strength: doc.get('strength') ?? '');
    }).toList();
  }

  //Userdata from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.get('name'),
        sugars: snapshot.get('sugars'),
        strength: snapshot.get('strength')
    );
  }

  // get coffee stream
  Stream<List<Coffee>> get coffee {
    return coffeeCollection.snapshots().map(_coffeeFromSnapshot);
  }

  // get user doc Stream
  Stream<UserData> get userData {
    return coffeeCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
