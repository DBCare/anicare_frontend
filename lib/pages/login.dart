import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isRememberMe = false;
  TextEditingController emailController =
      TextEditingController(); // emailController.text kullanarak girilen maili alabilirsin
  TextEditingController passwordController = TextEditingController();

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
<<<<<<< Updated upstream
        height: 35,
        child: Row(children: <Widget>[
          TextButton(
            onPressed: () => {/*ELİNİZDEN ÖPER*/},
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
=======
        height:35,
        child: Row(
            children: <Widget>[
              TextButton(
                onPressed: () => {/*ELİNİZDEN ÖPER*/},
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(width:60),
              const Text(
                  'Remember me?',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
              ),
              Theme(

                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  value: isRememberMe,
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  onChanged: (value) {
                    setState((){
                      isRememberMe = value!;
                    });
                  },
                ),
              ),

            ]
        )


    );
>>>>>>> Stashed changes
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
            onPressed: () {},
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
          onPressed: () {
            /*ELLERİNİZDEN ÖPER*/
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
