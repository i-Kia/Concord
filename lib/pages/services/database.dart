import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concord/pages/models/concorduser.dart';

class DataBaseService {

  final String? uid;
  DataBaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future? userExists(String username) async {
    QuerySnapshot querySnapshot = await userCollection.get();
    for(var i=0;i<querySnapshot.docs.length;i++){
      if (querySnapshot.docs[i].get('username') == username){
        return true;
      }
    }
    return false;
  }

  Future? updateUserData(String username, String photoUrl) async {
    return await userCollection.doc(uid).set({
      'username'  : username,
      'photo_url' : photoUrl
    });
  }

  List<ConcordUser> _concordUserFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      return ConcordUser(
        username: doc.get('username') ?? '',
        photoUrl: doc.get('photo_url') ?? '',
      );
    }).toList();
  }

  // get stream
  Stream<List<ConcordUser>> get users {
    return userCollection.snapshots()
      .map(_concordUserFromSnapshot);
  }

}