import 'package:cab_rider/core/utils/colors.dart';
import 'package:cab_rider/core/utils/page_routes.dart';
import 'package:cab_rider/core/widgets/progress_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _txtFullnameControlle = TextEditingController();
  final _txtEmailControlle = TextEditingController();
  final _txtPasswordControlle = TextEditingController();
  final _txtPhoneControlle = TextEditingController();

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
                  "Create a Rider's Account",
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
                        keyboardType: TextInputType.text,
                        controller: _txtFullnameControlle,
                        decoration: const InputDecoration(
                          label: Text("Full Name"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _txtEmailControlle,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          label: Text("Email Address"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _txtPhoneControlle,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          label: Text("Phone Number"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _txtPasswordControlle,
                        keyboardType: TextInputType.visiblePassword,
                        obscuringCharacter: "*",
                        obscureText: true,
                        decoration: const InputDecoration(
                          label: Text("Password"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {
                              doRegister();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: MyColors.colorGreen,
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)))),
                            child: const Text(
                              "REGISTER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have a RIDER account? "),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context,
                                    PagesRouteData.loginPage, (route) => false);
                              },
                              child: const Text("Log In here"))
                        ],
                      )
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

  void doRegister() async {
    showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (context) => const ProgressDialog("Register Progress"));
    if (checkFields()) {
      try {
        if (!await checkConnectivity()) {
          Navigator.pop(_context);
          showSnackBar("No Internet Connection");
          return;
        }
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _txtEmailControlle.text,
          password: _txtPasswordControlle.text,
        );
        if (credential.user != null) {
          DatabaseReference ref =
              FirebaseDatabase.instance.ref("user/${credential.user!.uid}");
          await ref.set({
            "fullName": _txtFullnameControlle.text,
            "email": _txtEmailControlle.text,
            "phone": _txtPhoneControlle.text,
          });
          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              _context, PagesRouteData.mainPage, (route) => false);
        } else {
          Navigator.pop(_context);
        }
      } on FirebaseAuthException catch (e) {
        Navigator.pop(_context);
        if (e.code == 'weak-password') {
          showSnackBar('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          showSnackBar('The account already exists for that email.');
        }
      } catch (e) {
        Navigator.pop(_context);
        showSnackBar('Error...');
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
    if (_txtFullnameControlle.text.length < 4) {
      showSnackBar("Valid Fullname has more than 3 characters");
      return false;
    }
    if (_txtEmailControlle.text.length < 6 ||
        !_txtEmailControlle.text.contains("@")) {
      showSnackBar("Invalid Email Address");
      return false;
    }
    if (_txtPhoneControlle.text.length < 11) {
      showSnackBar("Invalid Phone Number");
      return false;
    }
    if (_txtPasswordControlle.text.length < 8) {
      showSnackBar("Valid Password has more than 8 characters");
      return false;
    }
    return true;
  }

  showSnackBar(String txt) {
    var snackBar = SnackBar(
      content: Text(txt),
    );
    ScaffoldMessenger.of(_context).showSnackBar(snackBar);
  }
}
