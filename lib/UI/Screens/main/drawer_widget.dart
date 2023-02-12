import 'package:cab_rider/shared/constants/styles.dart';
import 'package:flutter/material.dart';

class MyDrawerWidget extends StatelessWidget {
  const MyDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: 250,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          SizedBox(
            height: 140,
            child: DrawerHeader(
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/user_icon.png",
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Mohammad Kahtooei",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {}, child: const Text("view profile")),
                    ],
                  )
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black38,
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(Icons.card_giftcard_outlined),
            title: Text(
              "Free Rides",
              style: kDrawerStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.credit_card_outlined),
            title: Text(
              "Payments",
              style: kDrawerStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.history_outlined),
            title: Text(
              "Ride History",
              style: kDrawerStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.contact_support_outlined),
            title: Text(
              "Support",
              style: kDrawerStyle,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: Text(
              "About",
              style: kDrawerStyle,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
