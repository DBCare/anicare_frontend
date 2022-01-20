import 'package:flutter/material.dart';

class CustomUpInformationBar extends StatelessWidget implements PreferredSize {
  BuildContext pageContext;
  String title = '';
  Color color;
  CustomUpInformationBar(
      {Key? key,
      required this.pageContext,
      required this.title,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(pageContext).size;
    final height = MediaQuery.of(pageContext).size.height -
        MediaQuery.of(pageContext).padding.top -
        MediaQuery.of(pageContext).padding.bottom;
    return PreferredSize(
      preferredSize: Size(size.width, height * 0.1),
      child: Center(
        child: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.only(left: 0.0),
            child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: const Color(0xFF29303E),
                onPressed: () {
                  Navigator.pop(pageContext);
                }),
          ),
          backgroundColor: color,
          title: Text(title,
              style: const TextStyle(color: Color(0xFF29303E), fontSize: 15)),
          elevation: 0,
        ),
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    Size size = MediaQuery.of(pageContext).size;
    final height = MediaQuery.of(pageContext).size.height -
        MediaQuery.of(pageContext).padding.top -
        MediaQuery.of(pageContext).padding.bottom;
    return Size(size.width, height * 0.1);
  }
}
