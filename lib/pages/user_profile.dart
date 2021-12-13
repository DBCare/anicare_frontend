import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.blueAccent,
          body: SafeArea(child: Column(
            children: <Widget>[
              const Text('Profile',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: CircleAvatar(radius: 40.0,
                    backgroundColor: Colors.white,
                    backgroundImage: AssetImage(
                        'assets/images/s-6087dc34879d8bfbaf0e50cb808a2dfd88d42fdb.jpg'),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 45.0,
                  ),
                  padding: const EdgeInsets.all(30.0),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: <Widget>[
                              Icon(Icons.local_hospital,
                                  size: 30,
                                  color: Colors.yellowAccent.shade400),
                              const SizedBox(
                                  width: 10.0
                              ),
                              const Text('2 Allergies',
                                style: TextStyle(color: Colors.black87),)
                            ],
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Row(
                            children: const <Widget>[
                              Icon(Icons.favorite,
                                  size: 30,
                                  color: Colors.blueAccent),
                              SizedBox(
                                  width: 10.0
                              ),
                              Text('30 Favorites',
                                style: TextStyle(color: Colors.black87),)
                            ],
                          )
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 70.0),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.star,
                                size: 30,
                                color: Colors.yellowAccent.shade400),
                            const SizedBox(
                                width: 10.0
                            ),
                            const Text('5 Badges', style: TextStyle(
                                color: Colors.black87),)
                          ],
                        ),
                      ),
                    ],
                  )
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 35),
                child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.settings, size: 30,
                                  color: Colors.blueAccent),
                              const SizedBox(
                                  width: 10.0
                              ),
                              const Text('Account Settings',
                                style: TextStyle(color: Colors.black,),),
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        138, 2, 2, 2),
                                    child: Icon(Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.lock, size: 30,
                                  color: Colors.blueAccent),

                              const SizedBox(
                                  width: 10.0
                              ),
                              const Text('Privacy & Security',
                                style: TextStyle(color: Colors.black,),),
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        132, 2, 2, 2),
                                    child: Icon(Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.notifications, size: 30,
                                  color: Colors.blueAccent),

                              const SizedBox(
                                  width: 10.0
                              ),
                              const Text('Notifications',
                                style: TextStyle(color: Colors.black,),),
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        165, 2, 2, 2),
                                    child: Icon(Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              const Icon(Icons.logout_outlined, size: 30,
                                  color: Colors.blueAccent),

                              const SizedBox(
                                  width: 10.0
                              ),
                              const Text('Log Out',
                                style: TextStyle(color: Colors.black,),),
                              Row(
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(
                                        192, 2, 2, 2),
                                    child: Icon(Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Colors.black45),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                            color: Colors.grey,
                            child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: const [
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                              Icons.wallet_giftcard, size: 30,
                                              color: Colors.blueAccent),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              20, 2, 2, 2),
                                          child: Text('Invite your friends'),
                                        ),
                                      ],
                                    ),
                                  )
                                ]
                            )
                        )
                      ],
                    )
                ),
              )
            ],
          )),
        )
    );
  }
}