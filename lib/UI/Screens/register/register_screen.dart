import 'package:cab_rider/core/utils/colors.dart';
import 'package:cab_rider/core/utils/page_routes.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      const TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          label: Text("Full Name"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextField(
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
                      const TextField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          label: Text("Phone Number"),
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const TextField(
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
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            onPressed: () {},
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
}
