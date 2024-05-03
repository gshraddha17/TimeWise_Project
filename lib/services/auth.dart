import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timewise/checkout_page.dart';
import 'package:timewise/edit_profile.dart';
import 'package:timewise/home.dart'; // Import Home
import 'package:timewise/services/database.dart';
import 'package:timewise/checkout_page.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    return _auth.currentUser;
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication? googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication?.idToken,
          accessToken: googleSignInAuthentication?.accessToken,
        );
        final UserCredential result =
            await _auth.signInWithCredential(credential);
        final User? userDetails = result.user;
        if (userDetails != null) {
          Map<String, dynamic> userInfoMap = {
            "email": userDetails.email,
            "name": userDetails.displayName,
            "imgUrl": userDetails.photoURL,
            "id": userDetails.uid
          };
          await DatabaseMethods().addUser(userDetails.uid, userInfoMap);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfilePage()), // Instantiate Home
          );
        }
      }
    } catch (e) {
      print("Error signing in with Google: $e");
    }
  }
}
