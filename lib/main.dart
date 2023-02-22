import 'package:cab_rider/UI/Screens/login/login_screen.dart';
import 'package:cab_rider/UI/Screens/main/main_screen.dart';
import 'package:cab_rider/UI/Screens/main/pages/search_page.dart';
import 'package:cab_rider/UI/Screens/register/register_screen.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/locator.dart';
import 'package:cab_rider/shared/resources/user_data.dart';
import 'package:cab_rider/shared/utils/page_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'config/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var currentUser = await FirebaseAuth.instance.currentUser;
  var initPage = PagesRouteData.loginPage;
  if (currentUser != null) {
    UserData user = UserData();
    user.id = currentUser.uid;
    user.email = currentUser.email;
    DatabaseReference ref = FirebaseDatabase.instance.ref("user/${user.id}");
    ref.once().then((DatabaseEvent dbEvent) {
      if (dbEvent.snapshot.value != null) {
        Map data = dbEvent.snapshot.value as Map;
        user.email = data['email'];
        user.fullName = data['fullName'];
        user.phone = data['phone'];
      }
    });
    initPage = PagesRouteData.mainPage;
  }

  await setUp();

  // runApp(const MyApp());
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MainScreenBloc>(create: (_) => getIt<MainScreenBloc>()),
  ], child: MyApp(initPage)));
}

class MyApp extends StatelessWidget {
  final String initPage;
  const MyApp(this.initPage, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Regular-Font',
        primarySwatch: Colors.blue,
      ),
      initialRoute: initPage,
      routes: {
        PagesRouteData.loginPage: (context) => LoginScreen(),
        PagesRouteData.registerPage: (context) => RegisterScreen(),
        PagesRouteData.mainPage: (context) => const MainScreen(),
        PagesRouteData.searchPage: (context) => SearchPage(),
      },
    );
  }
}
