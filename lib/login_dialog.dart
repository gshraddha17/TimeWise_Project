import 'package:flutter/material.dart';
import 'package:timewise/signup_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import GoogleSignIn package

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn(); // Create an instance of GoogleSignIn

void showLoginSignUpDialog(BuildContext context, {bool accountExists = true}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
        title: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            accountExists ? 'Login' : 'Sign Up',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (accountExists) {
                    // Perform Google authentication logic for login
                    _signInWithGoogle().then((_) {
                      Navigator.pop(context);
                    }).catchError((error) {
                      // Handle error
                    });
                  } else {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (accountExists)
                      Image.asset(
                        'assets/images/icons8-google-48.png',
                        height: 20,
                        width: 20,
                      ),
                    if (accountExists) const SizedBox(width: 10),
                    Text(
                      accountExists ? 'Login with Google' : 'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (!accountExists)
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              if (!accountExists) const SizedBox(height: 10),
              if (!accountExists)
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  if (accountExists) {
                    // Direct to Login page
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => LoginPage()),
                    // );
                  } else {
                    // Perform sign up logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF004AAD),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Text('Sign Up',

                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        actions: [
          if (accountExists)
            TextButton(
              onPressed: () {
                // Navigate to the Forgot Password page
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF004AAD),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: Text(
              accountExists ? 'Cancel' : 'Sign Up',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}

Future<UserCredential?> _signInWithGoogle() async {
  try {
    // Trigger the Google Sign-In flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the auth details from the returned GoogleUser
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
  } catch (error) {
    print('Error signing in with Google: $error');
    // Handle error
  }
}
