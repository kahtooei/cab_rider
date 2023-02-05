import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            print("Start");
            DatabaseReference ref =
                FirebaseDatabase.instance.ref("Test-$counter");
            await ref.set({"value": "My Value For Test"});
            print("End");
            counter++;
          },
          child: const Text("Add Text To Firebase Database"),
        ),
      ),
    );
  }
}
