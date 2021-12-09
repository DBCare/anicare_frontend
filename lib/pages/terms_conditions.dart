import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: const Text("TERMS & AGREEMENTS"),
        ),
      ),
    );
  }
}
