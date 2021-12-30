import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return MaterialApp(

        home:Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Column(
              children: [
                Row(children: [
                  Padding(padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.keyboard_arrow_left,size:40,),
                  ),
                  Container(
                    child:Row(
                      children: [
                        Padding(padding: const EdgeInsets.fromLTRB(85,5,5,5),
                        child: Text('Product List',style: TextStyle(color:Colors.white,fontWeight: FontWeight.normal,fontSize: 15 )),
                        ),
                      ],
                    ),
                  ),
                ],),
                Row(
                  children: [
                    Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
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
                      Padding(padding: const EdgeInsets.all(8.0),
                      child: Text('Product Categories',style: TextStyle(color:Colors.black,fontWeight: FontWeight.w800,fontSize: 25),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(150.0,1.0,4.0,5.0),
                      child: Icon(Icons.arrow_forward,),
                      ),
                    ],
                  )
                ),
                Container(
                  child:Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image.asset(
                                  'assets/images/img.png',
                                  width: 110.0,
                                  height: 110.0,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                color: Colors.white,
                                width: 110,
                                height: 30,
                                child: Center(
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  )
                )
              ],
            )
          )
        )

    );
  }
}
