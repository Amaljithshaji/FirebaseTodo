

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authmethod {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> signInWithGoogle() async {
    bool res = false;
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuth =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth?.accessToken,
          idToken: googleSignInAuth?.idToken);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          await _firestore.collection('user').doc(user.uid).set({
            'username': user.displayName,
            'uid': user.uid,
            
          });
        }
        res =true;
      }
    } catch (e) {
      res = false;
    }
    return res;
  }
}
