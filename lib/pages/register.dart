import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled/pages/main_menu.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String errorTitle = "Registration is unsuccesful!";
  bool success = true;
  Future<void> showMsg(String title, String errorMsg) async {
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

  FirebaseAuth auth = FirebaseAuth.instance;
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  String errorFill = "Please fill in all fields.\n";
  String errorPassword = "Passwords didn't match.\n";

  bool doesAgree = false;
  TextEditingController nameController =
      TextEditingController(); //nameController.text şeklinde kullanıcının girdiği değeri alabilirsin
  TextEditingController emailController = TextEditingController();
  TextEditingController pw1Controller = TextEditingController();
  TextEditingController pw2Controller = TextEditingController();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Widget buildNameField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                  controller: nameController,
                  obscureText: false,
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon:
                          Icon(Icons.perm_identity, color: Colors.black),
                      hintText: 'Name',
                      hintStyle: TextStyle(color: Colors.black38))))
        ]);
  }

  Widget buildEmailField() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(Icons.email, color: Colors.black),
                      hintText: 'Email',
                      hintStyle: TextStyle(color: Colors.black38))))
        ]);
  }

  Widget buildPasswordField(TextEditingController passwordController) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0, 2))
                  ]),
              height: 60,
              child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  style: const TextStyle(
                    color: Colors.black87,
                  ),
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 14),
                      prefixIcon: Icon(Icons.vpn_key, color: Colors.black),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.black38))))
        ]);
  }

  Widget buildAgreeCheckbox() {
    return SizedBox(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Theme(
        data: ThemeData(unselectedWidgetColor: Colors.black),
        child: Checkbox(
          value: doesAgree,
          checkColor: Colors.white,
          activeColor: Colors.black,
          onChanged: (value) {
            setState(() {
              doesAgree = value!;
            });
          },
        ),
      ),
      const Text('I agree',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
      TextButton(
        onPressed: () => {Navigator.pushNamed(context, '/terms')},
        child: const Text(
          'Terms & Conditions',
          style: TextStyle(
              color: Colors.yellow, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    ]));
  }

  Widget buildRegisterBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.grey[800],
                elevation: 5,
                padding: const EdgeInsets.all(10)),
            onPressed: () async {
              String error = "";
              if (nameController.text.isEmpty ||
                  emailController.text.isEmpty ||
                  pw1Controller.text.isEmpty ||
                  pw2Controller.text.isEmpty) {
                success = false;
                error += errorFill;
              }

              if (pw1Controller.text != pw2Controller.text) {
                success = false;
                error += errorPassword;
              }

              if (!doesAgree) {
                success = false;
                showMsg(
                    errorTitle, "Please agree Terms & Conditions to continue.");
              }

              if (success == false) {
                if (error.isNotEmpty) showMsg(errorTitle, error);
              } else {
                FirebaseAuth auth = FirebaseAuth.instance;
                User? user;
                try {
                  UserCredential userCredential =
                      await auth.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: pw1Controller.text,
                  );
                  user = auth.currentUser;
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    success = false;
                    showMsg(errorTitle, 'The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    success = false;
                    showMsg(errorTitle,
                        'The account already exists for that email.');
                  }
                } catch (e) {
                  success = false;
                  print(e);
                }

                if (success) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainMenu(),
                      ));

                  showMsg("Registration is successful!",
                      "You've succesfully signed up.");
                }
              }
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ));
  }

  Widget buildSocialRegister() {
    return SizedBox(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Image.asset(
              'assets/facebook.png',
              width: 20,
              height: 20,
            ), // <-- Use 'Image.asset(...)' here
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 40,
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              Future<UserCredential> userCredential = signInWithGoogle();
            },

            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Image.asset(
              'assets/google.png',
              width: 20,
              height: 20,
            ), // <-- Use 'Image.asset(...)' here
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 40,
          height: 40,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              padding: const EdgeInsets.all(5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Image.asset(
              'assets/apple.png',
              width: 20,
              height: 20,
            ), // <-- Use 'Image.asset(...)' here
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(children: <Widget>[
              Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: const Color(0xff4754F0),
                  child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              'assets/signup.png',
                              width: 200,
                              height: 130,
                            ),
                            buildNameField(),
                            const SizedBox(height: 20),
                            buildEmailField(),
                            const SizedBox(height: 20),
                            buildPasswordField(pw1Controller),
                            const SizedBox(height: 20),
                            buildPasswordField(pw2Controller),
                            buildAgreeCheckbox(),
                            buildRegisterBtn(),
                            const Text('or sign up with',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            const SizedBox(height: 20),
                            buildSocialRegister(),
                          ])))
            ])));
  }
}
