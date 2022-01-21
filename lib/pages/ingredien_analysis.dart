import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/custom_up_information_bar.dart';
import 'package:untitled/pages/recognize_text.dart';
import 'package:untitled/pages/scan_result.dart';

class IngredientAnalysis extends StatefulWidget {
  const IngredientAnalysis({Key? key}) : super(key: key);

  @override
  _IngredientAnalysisState createState() => _IngredientAnalysisState();
}

class _IngredientAnalysisState extends State<IngredientAnalysis> {
  TextEditingController ingredientsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomUpInformationBar(
        pageContext: context,
        title: "Analyze Ingredients",
        color: const Color(0xffF9F9F9),
      ),
      body: Center(
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Take a photo of the ingredients",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RecognizeTextScreen()));
                    },
                    child: const Text(
                      "Upload",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.black.withOpacity(0)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF4754F0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0),
                        )))),
                const SizedBox(
                  height: 30,
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                        child: const Divider(
                          indent: 100,
                          color: Colors.black,
                          thickness: 0.5,
                          height: 20,
                        )),
                  ),
                  const Text(
                    "or",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 20.0, right: 10.0),
                        child: const Divider(
                          endIndent: 100,
                          thickness: 0.5,
                          color: Colors.black,
                          height: 20,
                        )),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Copy-Paste Ingredients",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: 350,
                  height: 200,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: TextField(
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: ingredientsController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                    style: ButtonStyle(
                        shadowColor: MaterialStateProperty.all<Color>(
                            Colors.black.withOpacity(0)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF4754F0)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21.0),
                        ))),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return scanResult(
                                ingredientL: ingredientsController.text);
                          },
                        ),
                      );
                    },
                    child: const Text("Analyze")),
              ],
            )),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
