import 'package:flutter/material.dart';
import 'package:untitled/database_transactions/db_communication.dart';
import 'package:untitled/models/filter.dart';
import 'package:untitled/pages/search_product.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF9F9F9),
        body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.elliptical(100, 100),
                          bottomLeft: Radius.elliptical(60, 15)),
                      color: Colors.black87),
                  child: Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            color: Colors.white,
                            icon: const Icon(
                              Icons.keyboard_arrow_left,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        Row(
                          children: const [
                            Padding(
                              padding: EdgeInsets.fromLTRB(85, 5, 5, 5),
                              child: Text('Product List',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15)),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 8),
                          child: SizedBox(
                            width: 370,
                            height: 40,
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Vegan eyeshadow palette",
                                  hintStyle: const TextStyle(
                                      fontSize: 14, color: Color(0xffBAB9D0)),
                                  prefixIcon: const Icon(Icons.search,
                                      color: Colors.black87),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide.none),
                                  contentPadding: EdgeInsets.zero,
                                  filled: true,
                                  fillColor: const Color(0xffFCFCFF)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(top: 15.0, bottom: 15, left: 28),
                          child: Text(
                            'Product Categories',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  ])),
              FutureBuilder(
                  future: Future.wait([getBrands(), getCategories()]),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        Filter filter = Filter(snapshot.data![0],
                            snapshot.data![1], false, false, false);

                        return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        alignment: Alignment.center,
                                        child: MaterialButton(
                                          padding: const EdgeInsets.all(0),
                                          minWidth: 0,
                                          onPressed: () {
                                            filter.activateCategory('Makeup');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchProduct(
                                                    filter: filter,
                                                  ),
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25,
                                                              top: 25,
                                                              right: 25,
                                                              bottom: 15),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "assets/makeup.png"),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 25),
                                                    child: Text('Makeup',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                      alignment: Alignment.center,
                                      child: MaterialButton(
                                        padding: const EdgeInsets.all(0),
                                        minWidth: 0,
                                        onPressed: () {
                                          filter.activateCategory('Body Care');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchProduct(
                                                  filter: filter,
                                                ),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            top: 25,
                                                            right: 25,
                                                            bottom: 15),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/body-care.png"),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: Text('Body Care',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        alignment: Alignment.center,
                                        child: MaterialButton(
                                          padding: const EdgeInsets.all(0),
                                          minWidth: 0,
                                          onPressed: () {
                                            filter.activateCategory(
                                                'Dental Care');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchProduct(
                                                    filter: filter,
                                                  ),
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25,
                                                              top: 25,
                                                              right: 25,
                                                              bottom: 15),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "assets/dental-care.png"),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 25),
                                                    child: Text('Dental Care',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                      alignment: Alignment.center,
                                      child: MaterialButton(
                                        padding: const EdgeInsets.all(0),
                                        minWidth: 0,
                                        onPressed: () {
                                          filter.activateCategory('Hair Care');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchProduct(
                                                  filter: filter,
                                                ),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            top: 25,
                                                            right: 25,
                                                            bottom: 15),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/hair_care.png"),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: Text('Hair Care',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ]),
                              SizedBox(height: 10),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        alignment: Alignment.center,
                                        child: MaterialButton(
                                          padding: const EdgeInsets.all(0),
                                          minWidth: 0,
                                          onPressed: () {
                                            filter.activateCategory('Skincare');
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchProduct(
                                                    filter: filter,
                                                  ),
                                                ));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(0),
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8))),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.5,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 25,
                                                              top: 25,
                                                              right: 25,
                                                              bottom: 15),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          image:
                                                              DecorationImage(
                                                            image: AssetImage(
                                                                "assets/skin_care.png"),
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 25),
                                                    child: Text('Skincare',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black)),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              2.5,
                                      alignment: Alignment.center,
                                      child: MaterialButton(
                                        padding: const EdgeInsets.all(0),
                                        minWidth: 0,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchProduct(
                                                  filter: Filter(
                                                      snapshot.data![0],
                                                      snapshot.data![1],
                                                      false,
                                                      false,
                                                      false),
                                                ),
                                              ));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                                color: Color(0xff4754F0),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8))),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Column(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25,
                                                            top: 25,
                                                            right: 25,
                                                            bottom: 15),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/all-products.png"),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 25),
                                                  child: Text('All Products',
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  ])
                            ]);
                      }
                    }
                    return Column(children: []);
                  }),
            ],
          )),
        ));
  }
}
