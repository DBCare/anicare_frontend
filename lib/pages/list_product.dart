import 'package:flutter/material.dart';

class ListProduct extends StatefulWidget{
  const ListProduct({Key? key}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct>{

  @override
  Widget build(BuildContext context){
    return MaterialApp(

        home:Scaffold(
            backgroundColor: Color(0xffF9F9F9),
            body: SingleChildScrollView(
              child: SafeArea(
                  child: Column(
                    children: [
                      Row(children: [
                        Padding(padding: const EdgeInsets.all(8.0),
                          child: IconButton(icon: Icon(Icons.keyboard_arrow_left,size:40,),onPressed: () {Navigator.of(context).pop();},),
                        ),
                        Container(
                          child:Row(
                            children: [
                              Padding(padding: const EdgeInsets.fromLTRB(85,5,5,5),
                                child: Text('Product List',style: TextStyle(color:Colors.black,fontWeight: FontWeight.normal,fontSize: 15 )),
                              ),
                            ],
                          ),
                        ),
                      ],),
                      Row(
                        children: [
                          Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
                            child:
                            Container(
                              width: 370,
                              height: 40,
                              child:
                              TextField(
                                decoration: InputDecoration(
                                    hintText: "Vegan eyeshadow palette",
                                    hintStyle: TextStyle(fontSize: 14,color: Color(0xffBAB9D0)),
                                    prefixIcon: Icon(Icons.search,color:Color(0xff4754F0)),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none
                                    ),
                                    contentPadding: EdgeInsets.zero,
                                    filled: true,
                                    fillColor: Color(0xffFCFCFF)
                                ),
                              ),
                            ),),
                        ],
                      ),
                      Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: const EdgeInsets.all(5.0),
                                child: Text('Product Categories',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w800,fontSize: 20),),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(50,1.0,4.0,5.0),
                                child: IconButton(icon: Icon(Icons.arrow_forward,),onPressed: () {Navigator.of(context).pop();},),
                              ),
                            ],
                          )
                      ),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                              child:Row(
                                children: [
                                  TextButton(
                                    onPressed:() { },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/img_5.png',
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () { },
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/img_4.png',
                                              height: 150.0,
                                              width: 150,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                                mainAxisAlignment: MainAxisAlignment.center,
                              ),
                          ),
                          Container(
                            width: double.infinity,
                            child:Row(
                              children: [
                                TextButton(
                                  onPressed: () { },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/img_6.png',
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () { },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/img_7.png',
                                            height: 150.0,
                                            width: 150,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child:Row(
                              children: [
                                TextButton(
                                  onPressed: () { },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/img_8.png',
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                TextButton(
                                  onPressed: () { },
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child: Image.asset(
                                            'assets/images/img_9.png',
                                            height: 100.0,
                                            width: 150,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.center,
                          ),
                          ),
                        ],
                      )
                    ],
                  )
              ),
            )
        )
    );
  }
}
