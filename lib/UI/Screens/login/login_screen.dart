import 'dart:convert';

import 'package:cab_rider/UI/widgets/my_custom_buttom.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/data/remote/directions_api.dart';
import 'package:cab_rider/data/remote/geocoding.dart';
import 'package:cab_rider/data/remote/places_api.dart';
import 'package:cab_rider/repository/main_screen_repository.dart';
import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/repository/models/prediction.dart';
import 'package:cab_rider/shared/resources/request_status.dart';
import 'package:cab_rider/shared/resources/user_data.dart';
import 'package:cab_rider/shared/utils/colors.dart';
import 'package:cab_rider/shared/utils/page_routes.dart';
import 'package:cab_rider/UI/widgets/progress_dialog.dart';
import 'package:cab_rider/shared/utils/show_snackbar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _txtEmailControlle = TextEditingController();
  final _txtPasswordControlle = TextEditingController();

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Sign In as Rider",
                  style: TextStyle(
                      fontFamily: 'Bold-Font',
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 30),
                  child: Column(
                    children: [
                      TextField(
                        controller: _txtEmailControlle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          label: Text("Email Address"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _txtPasswordControlle,
                        keyboardType: TextInputType.visiblePassword,
                        obscuringCharacter: "*",
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text("Password"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      MyCustomButton(
                        onPress: login,
                        title: "LOGIN",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    PagesRouteData.registerPage,
                                    (route) => false);
                              },
                              child: const Text("Sign Up here"))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) => const ProgressDialog("Logging Progress"));
    if (checkFields()) {
      try {
        if (!await checkConnectivity()) {
          Navigator.pop(_context);
          showSnackBar("No Internet Connection", _context);
          return;
        }
        final _auth = FirebaseAuth.instance;
        UserCredential _user = await _auth.signInWithEmailAndPassword(
            email: _txtEmailControlle.text,
            password: _txtPasswordControlle.text);
        if (_user == null) {
          Navigator.pop(_context);
          showSnackBar("Wrong Email or Password", _context);
        } else {
          DatabaseReference ref =
              FirebaseDatabase.instance.ref("user/${_user.user!.uid}");

          ref.once().then((DatabaseEvent dbEvent) {
            if (dbEvent.snapshot.value != null) {
              Map data = dbEvent.snapshot.value as Map;
              UserData user = UserData();
              user.email = data['email'];
              user.fullName = data['fullName'];
              user.phone = data['phone'];
              user.id = _user.user!.uid;
              Navigator.pushNamedAndRemoveUntil(
                  _context, PagesRouteData.mainPage, (route) => false);
            } else {
              Navigator.pop(_context);
              showSnackBar("User Profile Data Not Found", _context);
            }
          });
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(_context);
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      } catch (e) {
        Navigator.pop(_context);
      }
    } else {
      Navigator.pop(_context);
    }
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print("Connection : ${ConnectivityResult.mobile}");
      return true;
    }
    return false;
  }

  bool checkFields() {
    if (_txtEmailControlle.text.length < 6 ||
        !_txtEmailControlle.text.contains("@")) {
      showSnackBar("Invalid Email Address", _context);
      return false;
    }

    if (_txtPasswordControlle.text.length < 8) {
      showSnackBar("Valid Password has more than 8 characters", _context);
      return false;
    }
    return true;
  }
}
