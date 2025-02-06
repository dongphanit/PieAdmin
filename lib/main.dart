import 'package:ecommerce_admin_panel/controllers/MenuController.dart';
import 'package:ecommerce_admin_panel/controllers/auth_controller.dart';
import 'package:ecommerce_admin_panel/controllers/dashboard_controller.dart';
import 'package:ecommerce_admin_panel/controllers/orders_controller.dart';
import 'package:ecommerce_admin_panel/controllers/product_controller.dart';
import 'package:ecommerce_admin_panel/screens/main/main_screen.dart';
import 'package:ecommerce_admin_panel/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'shared/remote/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: 'AIzaSyA-gZcWdnKyw_3Xg1ozmDqPtTHiEG-wS3U',
    appId: '1:761714459949:web:5c937371d332e8b6deffa4',
    messagingSenderId: '761714459949',
    projectId: 'traveltovietnam-3270d',
    authDomain: 'traveltovietnam-3270d.firebaseapp.com',
    storageBucket: 'traveltovietnam-3270d.firebasestorage.app',
    measurementId: 'G-8K3WXH5QXH',
  ),
);

  await DioHelper.init();
  //DesktopWindow.setMinWindowSize(Size(1300, 800));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AuthController(),
    ),
    ChangeNotifierProxyProvider<AuthController, MenuControllerA>(
      update: (context, auth, previousMenu) => MenuControllerA(auth),
      create: (BuildContext context) => MenuControllerA(null),
    ),
    ChangeNotifierProvider(
      create: (context) => OrdersController()..getAllorders(),
    ),
    ChangeNotifierProvider(
      create: (context) => ProductController()..getallProduct(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
       
        canvasColor: secondaryColor,
      ),
      home: MainScreen(),
    );
  }
}
