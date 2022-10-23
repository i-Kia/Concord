import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataBaseService {

  final String? uid;
  DataBaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future? updateUserData(String username) async {
    return await userCollection.doc(uid).set({
      'username': username,
    });
  }

}