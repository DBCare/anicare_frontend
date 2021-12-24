import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xffF9F9F9),
        child: ListView(
          shrinkWrap: true,
          children: [
              Center(child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: Text("Filter",style: TextStyle(fontSize: 18,color: Color(0xff4754F0))),
              )),
              Divider(
                color: Colors.black,
                thickness: 1,
                indent: 30,
                endIndent: 30,
              ),
              ExpansionTile(
                  title: Text("Categories"),
                  children: [
                    ListTile(
                      title: Text("Body Care"),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      title: Text("Cleaning"),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      title: Text("Hygiene"),
                      onTap: () {

                      },
                    ),
                    ListTile(
                      title: Text("Skin Care"),
                      onTap: () {

                      },
                    ),
                  ],
              ),
            ExpansionTile(
              title: Text("Brands"),
              children: [
                ListTile(
                  title: Text("3INA"),
                  onTap: () {

                  },
                ),
                ListTile(
                  title: Text("Acure"),
                  onTap: () {

                  },
                ),
                ListTile(
                  title: Text("AG Hair"),
                  onTap: () {

                  },
                ),
                ListTile(
                  title: Text("Adorn Cosmetics"),
                  onTap: () {

                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Divider(
                color: Colors.black,
                thickness: 1,
                indent: 30,
                endIndent: 30,
              ),
            ),
            ExpansionTile(
              title: Text("Sort By"),
              children: [
                ListTile(
                  title: Text("Name"),
                  onTap: () {

                  },
                ),
                ListTile(
                  title: Text("Brand"),
                  onTap: () {

                  },
                ),
                ListTile(
                  title: Text("Category"),
                  onTap: () {

                  },
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 80.0,horizontal: 30),
              child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          )),
                      backgroundColor: MaterialStateProperty.all ((const Color(0xff4754F0).withOpacity(1)))
                        ),
                  onPressed: () {
                        Navigator.of(context).pop();
                  },
                  child: const Text("List the products",
                      style: TextStyle(
                          color:Color(0xFFFFFFFF),
                          fontSize: 12))),
            ),
          ],
        ),
      ),
    );
  }
}
