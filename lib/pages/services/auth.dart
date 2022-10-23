import 'package:concord/pages/models/user.dart';
import 'package:concord/pages/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  UserObject? _userFromFirebaseUser(User? user){
    return user != null ? UserObject(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserObject?> get user => _auth.authStateChanges().map(_userFromFirebaseUser);

  Future? registerWithEmail(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = credential.user;

      // create a new document for the user with the uid
      await DataBaseService(uid: user!.uid).updateUserData('Baka');
      return _userFromFirebaseUser(user);

    } on FirebaseAuthException catch(e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return 'Email already in use';
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future? signInWithEmail(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = credential.user;

      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return null;
    } catch(e){
      return null;
    }
  }

  Future signOut() async {
    try {
      await _auth.signOut();
    } catch (e){
      print(e.toString());
      return null;
    }
  }
}