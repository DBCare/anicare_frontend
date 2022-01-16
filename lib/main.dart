import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/pages/brand_details.dart';
import 'package:untitled/pages/home.dart';
import 'package:untitled/pages/barcode_results.dart';
import 'package:untitled/pages/ingredien_analysis.dart';
import 'package:untitled/pages/login.dart';
import 'package:untitled/pages/main_menu.dart';
import 'package:untitled/pages/main_screen.dart';
import 'package:untitled/pages/register.dart';
import 'package:untitled/pages/request_product.dart';
import 'package:untitled/pages/search_product.dart';
import 'package:untitled/pages/product_details.dart';
import 'package:untitled/pages/terms_conditions.dart';
import 'package:untitled/pages/user_profile.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  runApp(MaterialApp(initialRoute: '/main', routes: {
    //'/': (context) => Loading(),
    '/main': (context) => const MainScreen(),
    '/register': (context) => const Register(),
    '/login': (context) => const Login(),
    '/home': (context) => const MainMenu(),
    '/barcode': (context) => const BarcodeResults(),
    '/search_product': (context) => SearchProduct(),
    '/product': (context) => const ProductDetails(),
    '/terms': (context) => const TermsConditions(),
    '/product_details': (context) => ProductDetails(),
    '/brand_details': (context) => BrandDetails(),
    '/request': (context) => RequestProduct(),
    '/analysis': (context) => IngredientAnalysis()
  }));
}
