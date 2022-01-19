import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled/customWidgets/custom_bottom_navigation_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Align(alignment: Alignment.center, child: Text("New Product Form")),
        backgroundColor: Color(0xdd4754F0),
        elevation: 0,
        leading: Icon(Icons.menu_rounded, size: 24),
        actions: [Icon(Icons.notifications_rounded)],
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/hair-care.png',
                    width: 100,
                    height: 100,
                  ),
                  Image.asset(
                    'assets/make-up.png',
                    width: 100,
                    height: 100,
                  ),
                  Image.asset(
                    'assets/skin-care.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Category",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: 350,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Category",
                        )),
                    isExpanded: true,
                    value: value,
                    iconSize: 36,
                    icon: Icon(Icons.arrow_drop_down),
                    items: categories.map(buildMenuItem).toList(),
                    onChanged: (value) {
                      setState(() {
                        this.value = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
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
              SizedBox(height: 10),
              Container(
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
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
              SizedBox(height: 10),
              Container(
                width: 350,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.edit),
                      labelText: 'Description*',
                      hintText: 'What do you know about this product?'),
                ),
              ),
              SizedBox(height: 10),
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
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
}
