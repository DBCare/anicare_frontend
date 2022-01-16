import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/functions/auth.dart';
import 'package:untitled/pages/login.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        appBar: AppBar(
          backgroundColor: const Color(0xff4754F0),
          elevation: 0,
          leading: const Icon(Icons.menu_rounded, size: 24),
          actions: const [Icon(Icons.notifications_rounded)],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 60.0),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: height * 0.30,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(150, 100),
                            bottomLeft: Radius.elliptical(600, 250)),
                        color: Color(0xff4754F0)),
                  ),
                  Positioned(
                    bottom: -20,
                    left: 0,
                    right: 0,
                    top: 10,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 5),
                      child: Container(
                          height: height * 0.30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xffFFFFFF)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    AssetImage('assets/mehmet.jpg'),
                              ),
                              Text(Auth.userProfile.name,
                                  style: const TextStyle(
                                      color: Color(0xff29303E),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    children: const [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundImage: AssetImage(
                                            "assets/allergy_icon.png"),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text("2 Allergies",
                                            style: TextStyle(
                                                color: Color(0xff29303E),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ) //Variable eklenecek
                                    ],
                                  ),
                                  Row(
                                    children: const [
                                      Icon(Icons.favorite,
                                          color: Color(0xff4754F0)),
                                      Padding(
                                        padding: EdgeInsets.only(left: 4.0),
                                        child: Text("30 Favorites",
                                            style: TextStyle(
                                                color: Color(0xff4754F0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14)),
                                      ) //Variable eklenecek
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 10,
                                    backgroundImage: ExactAssetImage(
                                        "assets/badge_icon.png"),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 4.0),
                                    child: Text("5 Badges",
                                        style: TextStyle(
                                            color: Color(0xff29303E),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                  ) //Variable eklenecek
                                ],
                              )
                            ],
                          )),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {},
                          label: Align(
                              alignment: Alignment.centerLeft,
                              child: const Text("Account Settings",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          icon: const Icon(Icons.settings,
                              color: Color(0xff4754F0)),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Privacy & Security",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          icon:
                              const Icon(Icons.lock, color: Color(0xff4754F0)),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {},
                          label: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Notifications",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          icon: const Icon(Icons.notifications,
                              color: Color(0xff4754F0)),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () {
                            Auth.signOut();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Login(),
                                ));
                          },
                          label: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Log out",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold))),
                          icon: const Icon(Icons.logout,
                              color: Color(0xff4754F0)),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Container(
                          color: const Color(0xffE0DFE9),
                          width: double.infinity,
                          child: TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.card_giftcard,
                                  color: Color(0xff4754F0)),
                              label: const Padding(
                                padding: EdgeInsets.only(left: 4.0),
                                child: Text("Invite your friends",
                                    style: TextStyle(
                                        color: Color(0xff29303E),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
