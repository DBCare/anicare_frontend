import 'package:analyzer_plugin/utilities/pair.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/filter.dart';
import 'package:untitled/pages/search_product.dart';

class CustomDrawer extends StatefulWidget {
  final Filter filter;
  const CustomDrawer({Key? key, required this.filter}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState(filter);
}

class _CustomDrawerState extends State<CustomDrawer> {
  late Filter filter;
  _CustomDrawerState(this.filter);
  Widget _buildTiles(List<Pair<String, bool>> buildList, String title) {
    return ExpansionTile(
      title: Text(title),
      children: <Widget>[
        ListView.builder(
          itemCount: buildList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(buildList[index].first,
                  style: TextStyle(
                      color:
                          buildList[index].last ? Colors.white : Colors.black)),
              tileColor: buildList[index].last ? Color(0xff4754F0) : null,
              onTap: () {
                setState(() {
                  buildList[index] =
                      Pair(buildList[index].first, !buildList[index].last);
                });
              },
            );
          },
          shrinkWrap: true,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            Center(
                child: Padding(
              padding: EdgeInsets.symmetric(vertical: 25.0),
              child: Text("Filter",
                  style: TextStyle(fontSize: 18, color: Color(0xff4754F0))),
            )),
            Divider(
              color: Colors.black,
              thickness: 1,
              indent: 30,
              endIndent: 30,
            ),
            _buildTiles(filter.categoryFilter, 'Categories'),
            _buildTiles(filter.brandFilter, 'Brands'),
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
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Brand"),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Category"),
                  onTap: () {},
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 80.0, horizontal: 30),
              child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                      backgroundColor: MaterialStateProperty.all(
                          (const Color(0xff4754F0).withOpacity(1)))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("List the products",
                      style:
                          TextStyle(color: Color(0xFFFFFFFF), fontSize: 12))),
            ),
          ],
        ),
      ),
    );
  }
}
