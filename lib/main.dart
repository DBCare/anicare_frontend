import 'package:flutter/material.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/pages/barcode_results.dart';
import 'package:untitled/pages/login.dart';
import 'package:untitled/pages/main_screen.dart';
import 'package:untitled/pages/register.dart';
import 'package:untitled/pages/search_product.dart';
import 'package:untitled/pages/product_details.dart';
import 'package:untitled/pages/terms_conditions.dart';
import 'package:untitled/pages/user_profile.dart';

void main() => runApp(MaterialApp(initialRoute: '/main', routes: {
      //'/': (context) => Loading(),
      '/main' : (context) => const UserProfile(),
      '/register' : (context) => const Register(),
      '/login' : (context) => const Login(),
      '/home': (context) => const Home(),
      '/barcode': (context) => const BarcodeResults(),
      '/search_product': (context) => const SearchProduct(),
      '/product': (context) => const ProductDetails(),
      '/terms': (context) => const TermsConditions()
    }));
