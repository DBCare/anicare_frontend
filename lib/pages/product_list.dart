import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home:Scaffold(
            backgroundColor: Colors.white70,
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(icon: const Icon(Icons.keyboard_arrow_left,size: 40,), onPressed: () { Navigator.of(context).pop(); },),
                      ),
                      Row(
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(85,5,5,5),
                            child: Text('Brands',style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal,fontSize: 15)),
                          )
                        ],
                      ),
                    ],),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
                          child:
                          Container(
                            width: 370,
                            height: 40,
                            child:
                            TextField(
                              decoration: InputDecoration(
                                  hintText: "Vegan eyeshadow palette",
                                  hintStyle: const TextStyle(fontSize: 14,color: Color(0xffBAB9D0)),
                                  prefixIcon: const Icon(Icons.search,color: Color(0xff4754F0)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  fillColor: const Color(0xffFCFCFF)
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('All Brands A-Z',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 25),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(150.0,1.0,4.0,5.0),
                          child: IconButton(icon: const Icon(Icons.arrow_forward,),onPressed: () { Navigator.of(context).pop(); }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {  },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(
                                      'assets/images/img.png',
                                      width: 150.0,
                                      height: 110.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                      color: Colors.white,
                                      width: 150,
                                      height: 30,
                                      child: const Center(
                                        child: Text('100% Pure',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            ),

                            TextButton(
                              onPressed: () {  },
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12.0),
                                    child: Image.asset(
                                      'assets/images/img_1.png',
                                      width: 150.0,
                                      height: 110.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Container(
                                      color: Colors.white,
                                      width: 150,
                                      height: 30,
                                      child: const Center(
                                        child: Text('14e Cosmetics',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),
                                        ),
                                      )
                                  )
                                ],
                              ),
                            )
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {  },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(
                                        'assets/images/img_2.png',
                                        width: 150.0,
                                        height: 110.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                        color: Colors.white,
                                        width: 150,
                                        height: 30,
                                        child: const Center(
                                          child: Text('3INA',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {  },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(
                                        'assets/images/img_3.png',
                                        width: 150.0,
                                        height: 110.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                        color: Colors.white,
                                        width: 150,
                                        height: 30,
                                        child: const Center(
                                          child: Text('Acure',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        )
                        ,
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              TextButton(
                                onPressed: () {  },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(
                                        'assets/images/img_4.png',
                                        width: 150.0,
                                        height: 110.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                        color: Colors.white,
                                        width: 150,
                                        height: 30,
                                        child: const Center(
                                          child: Text('Adorn Cosmetics',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 14),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {  },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image.asset(
                                        'assets/images/img_5.png',
                                        width: 150.0,
                                        height: 110.0,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                        color: Colors.white,
                                        width: 150,
                                        height: 30,
                                        child: const Center(
                                          child: Text('AG Hair',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800,fontSize: 15),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}
