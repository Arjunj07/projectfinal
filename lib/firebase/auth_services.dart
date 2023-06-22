import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static final _firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final firestore = FirebaseFirestore.instance;
  static signout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String> signup(
      {String? email, String? password, String? role, String? username}) async {
    String res = "Something went wrong";
    try {
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      res = "Success";

      print(cred.user!.uid);
      if (role == 'USER') {
        await _firestore.collection('users').doc(cred.user!.uid).set({
          'email': email,
          'uid': cred.user!.uid,
          'username': username,
          'role': role
        });
      } else if (role == 'OWNER') {
        await _firestore.collection('owners').doc(cred.user!.uid).set({
          'email': email,
          'uid': cred.user!.uid,
          'username': username,
          'role': role
        });
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  static Future<String> login(
      {required String email, required String password}) async {
    String res = "Something went wrong";
    print('hello');
    try {
      print('hi');
      UserCredential cred = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      final role = await getrole();
      res = role;
      print(res);
    } catch (e) {
      res = e.toString();
    }
    print(res);
    return res;
  }

  static getrole() async {
    String res = "something went wrong";
    try {
      String uid = _firebaseAuth.currentUser!.uid;
      final data = await firestore.collection('users').doc(uid).get();
      final data1 = await firestore.collection('owners').doc(uid).get();
      if (data.data() != null) {
        res = data.data()!['role'];
      } else if (data1.data() != null) {
        res = data1.data()!['role'];
      }
    } catch (e) {
      res = e.toString();
      print(res);
    }
    return res;
  }
}
