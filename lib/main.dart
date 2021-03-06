import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:untitled/functions/auth.dart';
import 'package:untitled/models/user.dart';
import 'package:untitled/pages/brand_details.dart';
import 'package:untitled/pages/barcode_results.dart';
import 'package:untitled/pages/ingredien_analysis.dart';
import 'package:untitled/pages/list_product.dart';
import 'package:untitled/pages/login.dart';
import 'package:untitled/pages/main_menu.dart';
import 'package:untitled/pages/main_screen.dart';
import 'package:untitled/pages/register.dart';
import 'package:untitled/pages/request_product.dart';
import 'package:untitled/pages/product_details.dart';
import 'package:untitled/pages/terms_conditions.dart';

import 'database_transactions/db_communication.dart';

List<CameraDescription> cameras = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  cameras = await availableCameras();
  if (Auth.getCurrUser() != null) {
    UserProfile? tempProfile = await getUser(Auth.getCurrUser()!.uid);
    if (tempProfile == null) {
      Auth.signOut();
    } else {
      Auth.userProfile = tempProfile;
    }
  }
  runApp(MaterialApp(
      initialRoute: Auth.userProfile == null ? '/main' : '/home',
      routes: {
        //'/': (context) => Loading(),
        '/main': (context) => const MainScreen(),
        '/register': (context) => const Register(),
        '/login': (context) => const Login(),
        '/home': (context) => const MainMenu(),
        '/barcode': (context) => const BarcodeResults(),
        '/product': (context) => const ProductDetails(),
        '/terms': (context) => const TermsConditions(),
        '/product_details': (context) => ProductDetails(),
        '/brand_details': (context) => const BrandDetails(),
        '/request': (context) => const RequestProduct(),
        '/analysis': (context) => const IngredientAnalysis(),
        '/category_list': (context) => const ListProduct(),
      }));
}
