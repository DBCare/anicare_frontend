import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/user.dart';

class Auth {
  static final FirebaseAuth auth = FirebaseAuth.instance;
  static UserProfile? userProfile;
  static bool isRememberMe = false;

  static showMsg(String title, String errorMsg, BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorMsg),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static Future<User?> loginApp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String err = "";
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        err = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        err = 'Wrong password provided.';
      } else {
        err = "An error occured. Please try again.";
      }
      showMsg("Login is unsuccessful!", err, context);
      debugPrint(e.toString());
    }

    return user;
  }

  static User? getCurrUser() {
    User? refreshedUser = auth.currentUser;

    return refreshedUser;
  }

  static bool validateFields(String email, String name, String pw1, String pw2,
      bool doesAgree, BuildContext context) {
    if (name.isEmpty || email.isEmpty || pw1.isEmpty || pw2.isEmpty) {
      showMsg("Registration is unsuccessful!", "Please fill in all fields",
          context);
      return false;
    }

    if (!doesAgree) {
      showMsg("Registration is unsuccessful!",
          "Please agree Terms & Conditions to continue.", context);
      return false;
    }

    if (pw1 != pw2) {
      showMsg("Registration is unsuccessful!", "Passwords did not matched.",
          context);
      return false;
    }

    return true;
  }

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    User? user;
    String err = "";
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(name);
      await user.reload();
      user = auth.currentUser;
      userProfile = UserProfile(user!.uid, name, email, null, List.empty(),
          List.empty(), List.empty());
      pushUser(userProfile!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        err += "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        err += "The account already exists for that email.";
      } else if (e.code == 'invalid-email') {
        err += "Please enter a valid e-mail adress.";
      } else {
        err = "An error occured. Please try again.";
      }
      showMsg("Registration is unsuccessful!", err, context);
      debugPrint(e.toString());
    }

    return user;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;
    String err = "";

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        userProfile = UserProfile(user!.uid, user.displayName!, user.email!, "",
            List.empty(), List.empty(), List.empty());
        pushUser(userProfile!);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          err = "This account exists with a different credential.";
        } else if (e.code == 'invalid-credential') {
          err = "Invalid credential.";
        }
        showMsg("Login is unsuccessful!", err, context);
        debugPrint(e.toString());
      }
    }

    return user;
  }

  static signOut() {
    userProfile == null;
    return auth.signOut();
  }

  static Future sendPasswordResetEmail(String email) async {
    return auth.sendPasswordResetEmail(email: email);
  }
}
