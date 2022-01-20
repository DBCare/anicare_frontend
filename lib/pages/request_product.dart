import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
import 'package:untitled/customWidgets/custom_up_information_bar.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/functions/auth.dart';
import 'package:untitled/models/request.dart';

class RequestProduct extends StatefulWidget {
  const RequestProduct({Key? key}) : super(key: key);

  @override
  _RequestProductState createState() => _RequestProductState();
}

class _RequestProductState extends State<RequestProduct> {
  @override
  Widget build(BuildContext context) {
    const appTitle = 'New Product Details';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final categories = [
    'Body Care',
    'Dental Care',
    'Hair Care',
    'Makeup',
    'Skincare'
  ];
  TextEditingController productNameController =
      TextEditingController(); // emailController.text kullanarak girilen maili alabilirsin
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? value;
  final BoxDecoration _boxDecoration =
      BoxDecoration(border: Border.all(color: Colors.black, width: 0.5));

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: CustomUpInformationBar(
          pageContext: context,
          title: 'Request a New Product',
          color: const Color(0xffF9F9F9)),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              width: 350,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: _boxDecoration,
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: TextField(
                      decoration: InputDecoration(
                        icon: Icon(Icons.ballot_rounded),
                        labelText: 'Category',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  isExpanded: true,
                  value: value,
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_drop_down),
                  items: categories.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 350,
              decoration: _boxDecoration,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.article),
                    hintText: 'What is the name of the Product?',
                    labelText: 'Product Name',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 350,
              decoration: _boxDecoration,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: brandController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.add_business_rounded),
                    hintText: 'Which brand produces this product?',
                    labelText: 'Brand',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 350,
              height: 200,
              decoration: _boxDecoration,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.edit),
                      labelText: 'Description (Optional)',
                      hintText: 'What do you know about this product?'),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Request req = Request(
                      productNameController.text,
                      brandController.text,
                      value!,
                      descriptionController.text,
                      'pending');
                  if (req.validateRequest()) {
                    try {
                      addRequest(req);
                    } catch (exception) {
                      Auth.showMsg('Request',
                          "Couldn't send request. Network error!", context);
                    }
                    Auth.showMsg(
                        'Request', 'Request sent successfully', context);
                  } else {
                    Auth.showMsg(
                        'Request',
                        "Couldn't send request. Please fill all the required fields",
                        context);
                  }
                },
                child: const Text("Submit"),
                style: ButtonStyle(
                    shadowColor: MaterialStateProperty.all<Color>(
                        Colors.black.withOpacity(0)),
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF4754F0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(21.0),
                    ))),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontSize: 14),
        ),
      );
}
