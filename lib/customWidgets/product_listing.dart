import 'package:flutter/material.dart';

class ProductListing extends StatelessWidget {
  List<Map<String, dynamic>> items;
  int boldLength;
  String route;
  ProductListing(
      {required this.items, required this.boldLength, required this.route});

  @override
  Widget build(BuildContext context) {
    String result = '';
    return Expanded(
      child: Scrollbar(
        child: ListView.builder(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              width: double.infinity,
              height: 70,
              child: Center(
                child: ListTile(
                  contentPadding: const EdgeInsets.all(0),
                  onTap: () {
                    result = items[index]['id'];
                    Navigator.pushNamed(context, route, arguments: result);
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(items[index]['pic-url']),
                    backgroundColor: Colors.white,
                  ),
                  title: RichText(
                      text: TextSpan(
                          text: items[index]['name'].substring(0, boldLength),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          children: [
                        TextSpan(
                          text: items[index]['name'].substring(boldLength),
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      ])),
                  subtitle: Text(items[index]['category'],
                      style: const TextStyle(
                          color: Color(0xff4754F0), fontSize: 13)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Color(0xffBAB9D0)),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                ),
              ),
            ),
          ),
          itemCount: items.length,
        ),
      ),
    );
  }
}
