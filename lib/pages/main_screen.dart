import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  Widget buildLoginBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,

        child: SizedBox(
          height:50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 5,
                padding: const EdgeInsets.all(10)
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/login');
            },
            child: const Text(
              'Login',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
              ),
            ),
          ),
        )
    );
  }


  Widget buildRegisterBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,

        child: SizedBox(
          height:50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Colors.white,
                elevation: 5,
                padding: const EdgeInsets.all(10)
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/register');
            },
            child: const Text(
              'Sign up',
              style: TextStyle(
                  color: Colors.black87,
                  fontSize: 20,
              ),
            ),
          ),
        )
    );
  }

  Widget buildContinueWithoutProfileBtn() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,

        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              primary: Colors.grey[800],
              elevation: 5,
              padding: const EdgeInsets.all(10)
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
          child: const Text(
            'Continue without a profile',
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
            ),
          ),
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
                children: <Widget>[
                  Container(
                      height: double.infinity,
                      width: double.infinity,
                      color:const Color(0xff4754F0),
                      child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 180
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/bunnyLogo.png',
                                  width:180,
                                  height:180,
                                ),
                                const SizedBox(height:120),
                                buildLoginBtn(),
                                buildRegisterBtn(),
                                buildContinueWithoutProfileBtn(),

                              ]
                          )
                      )
                  )
                ]
            )
        )
    );
  }


}
