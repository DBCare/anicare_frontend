import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
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
      appBar: AppBar(
        title: const Align(alignment:Alignment.center,child: Text("Analyze Ingredients")),
        backgroundColor: const Color(0xdd4754F0),
        elevation: 0,
        leading: const Icon(Icons.menu_rounded, size: 24),
        actions: const [Icon(Icons.notifications_rounded)],
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              const Text("Take a photo of the ingredients",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const RecognizeTextScreen()));
              }, child: const Text("Upload")),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Image.asset('assets/line.png',width: 40,height: 40,),
                  const Text(" or ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Image.asset('assets/line.png',width: 40,height: 40,),
              ]
              ),
              const SizedBox(height: 30,),
              const Text("Copy-Paste Ingredients",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 30,),
              Container(
                width:350,
                height:200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller:ingredientsController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,

                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return scanResult(ingredientL: ingredientsController.text);
                      },
                    ),
                  );
                },
                child: const Text("Analyze")),
            ],
          )
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
