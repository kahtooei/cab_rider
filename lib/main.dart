import 'package:cab_rider/UI/Screens/login/login_screen.dart';
import 'package:cab_rider/UI/Screens/main/main_screen.dart';
import 'package:cab_rider/UI/Screens/main/pages/search_page.dart';
import 'package:cab_rider/UI/Screens/register/register_screen.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/locator.dart';
import 'package:cab_rider/shared/utils/page_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'config/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setUp();

  // runApp(const MyApp());
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MainScreenBloc>(create: (_) => getIt<MainScreenBloc>()),
  ], child: MyApp()));
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
        PagesRouteData.loginPage: (context) => LoginScreen(),
        PagesRouteData.registerPage: (context) => RegisterScreen(),
        PagesRouteData.mainPage: (context) => const MainScreen(),
        PagesRouteData.searchPage: (context) => const SearchPage(),
      },
    );
  }
}
