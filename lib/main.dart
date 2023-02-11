import 'package:cab_rider/UI/Screens/login/login_screen.dart';
import 'package:cab_rider/UI/Screens/main/main_screen.dart';
import 'package:cab_rider/UI/Screens/register/register_screen.dart';
import 'package:cab_rider/core/utils/page_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Regular-Font',
        primarySwatch: Colors.blue,
      ),
      initialRoute: PagesRouteData.loginPage,
      routes: {
        PagesRouteData.loginPage: (context) => const LoginScreen(),
        PagesRouteData.registerPage: (context) => RegisterScreen(),
        PagesRouteData.mainPage: (context) => const MainScreen(),
      },
    );
  }
}
