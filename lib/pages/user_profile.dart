import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/functions/auth.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/pages/login.dart';

import 'main_menu.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  TextEditingController allergyController = TextEditingController();

  Widget dismissibleCard(List list, int index, BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        setState(() {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(list[index].toString().toCapitalized() +
                " is removed from the allergies."),
          ));
          Auth.userProfile!.removeAllergy(index);
        });
      },
      child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ListTile(
            title: Text(list[index].toString().toCapitalized()),
          )),
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  Future<void> allergyView(List allergies) async {
    final GlobalKey<ScaffoldState> _modelScaffoldKey =
        GlobalKey<ScaffoldState>();
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Scaffold(
            extendBody: false,
            key: _modelScaffoldKey,
            resizeToAvoidBottomInset: true,
            body: Column(children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 300,
                        child: TextField(
                          controller: allergyController,
                          decoration: const InputDecoration(
                            labelText: 'New Allergic Ingredient:',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 5),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              final String item = allergyController.text;
                              if (Auth.userProfile!.addAllergy(item)) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      item.toString().toCapitalized() +
                                          " is added to the allergies."),
                                ));
                              } else {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      "You can't add the same ingredient twice."),
                                ));
                              }

                              allergyController.clear();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF4754F0),
                            padding: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                          ),
                          child: const Text("Add"),
                        ),
                      ),
                    ],
                  )),
              Expanded(
                child: allergies.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: allergies.length,
                        itemBuilder: (BuildContext context, int index) {
                          return dismissibleCard(allergies, index, context);
                        })
                    : const Center(
                        child: Text(
                            "You haven't add any allergic ingredient yet.",
                            style: TextStyle(
                                color: Color(0xff4754F0),
                                fontWeight: FontWeight.bold,
                                fontSize: 14))),
              )
            ]),
          );
        });
  }

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
                              if ((Auth.userProfile!.imgURL == null) ||
                                  (Auth.userProfile!.imgURL != null &&
                                      Auth.userProfile!.imgURL!.isEmpty))
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/avatar.png'),
                                ),
                              if (Auth.userProfile!.imgURL != null &&
                                  Auth.userProfile!.imgURL!.isNotEmpty)
                                const CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      AssetImage('assets/avatar.png'),
                                ),
                              Text(Auth.userProfile!.name,
                                  style: const TextStyle(
                                      color: Color(0xff29303E),
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainMenu(),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.favorite,
                                            color: Color(0xff4754F0)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                              Auth.userProfile!.favProducts
                                                      .length
                                                      .toString() +
                                                  " Favorite Products",
                                              style: const TextStyle(
                                                  color: Color(0xff4754F0),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const MainMenu(),
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        const Icon(Icons.favorite,
                                            color: Color(0xff4754F0)),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 4.0),
                                          child: Text(
                                              Auth.userProfile!.favBrands.length
                                                      .toString() +
                                                  " Favorite Brands",
                                              style: const TextStyle(
                                                  color: Color(0xff4754F0),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14)),
                                        ) //Variable eklenecek
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              GestureDetector(
                                onTap: () {
                                  allergyView(Auth.userProfile!.allergies);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const CircleAvatar(
                                      radius: 10,
                                      backgroundImage:
                                          AssetImage("assets/allergy_icon.png"),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Text(
                                          Auth.userProfile!.allergies.length
                                                  .toString() +
                                              " Allergies",
                                          style: const TextStyle(
                                              color: Color(0xff29303E),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14)),
                                    ) //Variable eklenecek
                                  ],
                                ),
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
                          label: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Account Settings",
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
