import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/pages/main_menu.dart';
import 'package:untitled/functions/auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRememberMe = false;
  bool isForget = false;
  TextEditingController emailController =
      TextEditingController(); // emailController.text kullanarak girilen maili alabilirsin
  TextEditingController passwordController = TextEditingController();
  TextEditingController forgetPasswordController = TextEditingController();

  Future<FirebaseApp> initializeFirebaseWithUser() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const MainMenu(),
        ),
      );
    }
    return firebaseApp;
  }

  Future<void> getEmailForForgetPw(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Please enter your e-mail:'),
            content: TextField(
              controller: forgetPasswordController,
              decoration: const InputDecoration(hintText: "your@email.com"),
              keyboardType: TextInputType.emailAddress,
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isForget = true;
                    Navigator.pop(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xFF4754F0),
                  padding: const EdgeInsets.all(5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text("Ok"),
              ),
            ],
          );
        });
  }

  Widget buildEmail() {
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

  Widget buildPassword() {
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

  Widget buildRememberMeAndForgotPW() {
    return SizedBox(
        height: 35,
        child: Row(children: <Widget>[
          TextButton(
            onPressed: () async {
              isForget = false;
              await getEmailForForgetPw(context);
              if (isForget && forgetPasswordController.text.isNotEmpty) {
                try {
                  await Auth.sendPasswordResetEmail(
                      forgetPasswordController.text);
                  Auth.showMsg(
                      "E-mail has been sent!",
                      "Please check your e-mail to reset your password.",
                      context);
                } catch (e) {
                  Auth.showMsg("Wrong e-mail!",
                      "This e-mail is not registered in our system.", context);
                }
              }
            },
            child: const Text(
              'Forgot Password?',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 60),
          const Text('Remember me?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.black,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  isRememberMe = value!;
                });
              },
            ),
          ),
        ]));
  }

  Widget buildSocialLogins() {
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
            onPressed: () async {
              User? user = await Auth.signInWithGoogle(context: context);
              if (user != null) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const MainMenu(),
                    ));
              }
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

  Widget buildSignUpButton() {
    return GestureDetector(
        onTap: () => {Navigator.pushNamed(context, '/register')},
        child: RichText(
            text: const TextSpan(children: [
          TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400)),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ])));
  }

  Widget buildLoginButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.grey[800],
              elevation: 5,
              padding: const EdgeInsets.all(10)),
          onPressed: () async {
            User? user = await Auth.loginApp(
                email: emailController.text,
                password: passwordController.text,
                context: context);
            if (user != null) {
              UserProfile? tempProfile = await getUser(user.uid);
              if (tempProfile != null) Auth.userProfile = tempProfile;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainMenu()),
                ModalRoute.withName('/'),
              );
            }
          },
          child: const Text(
            'Sign in',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
                              'assets/welcome.png',
                              width: 180,
                              height: 180,
                            ),
                            buildEmail(),
                            const SizedBox(height: 40),
                            buildPassword(),
                            buildRememberMeAndForgotPW(),
                            const SizedBox(height: 40),
                            buildLoginButton(),
                            const SizedBox(height: 10),
                            const Text('or sign in with',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            const SizedBox(height: 20),
                            buildSocialLogins(),
                            const SizedBox(height: 60),
                            buildSignUpButton(),
                          ])))
            ])));
  }
}
