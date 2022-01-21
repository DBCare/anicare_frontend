import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
  TextEditingController productNameController =
      TextEditingController(); // emailController.text kullanarak girilen maili alabilirsin
  TextEditingController brandController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? value;

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );

  @override
  Widget build(BuildContext context) {
    const appTitle = 'New Product Details';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
          body: Scaffold(
        appBar: CustomUpInformationBar(
            pageContext: context,
            title: 'Request Product Form',
            color: Color(0xffF9F9F9)),
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
                  child: FutureBuilder(
                      future: getCategories(),
                      builder:
                          (BuildContext context, AsyncSnapshot<List> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            List categories = snapshot.data!;
                            return DropdownButtonHideUnderline(
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
                                items: (categories as List<String>)
                                    .map(buildMenuItem)
                                    .toList(),
                                onChanged: (value) {
                                  setState(() {
                                    this.value = value;
                                  });
                                },
                              ),
                            );
                          }
                        }

                        return DropdownButtonHideUnderline(
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
                            items: [],
                            onChanged: (value) {
                              setState(() {
                                this.value = value;
                              });
                            },
                          ),
                        );
                      }),
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
      )),
    );
  }
}
