import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_status.dart';
import 'package:cab_rider/shared/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  final _txtPickupController = TextEditingController();
  final _txtDestinationController = TextEditingController();
  final _focusDestination = FocusNode();
  bool isFirstInit = true;

  firstInit(BuildContext context) {
    if (isFirstInit) {
      String picupAddress = "";
      FocusScope.of(context).requestFocus(_focusDestination);
      var currentLocation =
          context.read<MainScreenBloc>().state.currentPosition;
      if (currentLocation is CompleteMainScreenStatus) {
        picupAddress = currentLocation.address.placeFormattedAddress!;
      }
      isFirstInit = false;
      _txtPickupController.text = picupAddress;
    }
  }

  @override
  Widget build(BuildContext context) {
    firstInit(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 180,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: const BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    blurRadius: 5, color: Colors.black45, spreadRadius: 0.5)
              ]),
              child: Column(
                children: [
                  Stack(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black87,
                          )),
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(
                            "Set Destination",
                            style: TextStyle(
                                fontFamily: "Bold-Font",
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/pickicon.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MyColors.colorLightGrayFair),
                        child: TextField(
                          controller: _txtPickupController,
                          decoration: const InputDecoration(
                              hintText: "Pickup location",
                              fillColor: MyColors.colorLightGrayFair,
                              filled: true,
                              isDense: true,
                              border: InputBorder.none),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/desticon.png",
                        height: 20,
                        width: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: MyColors.colorLightGrayFair),
                        child: TextField(
                          controller: _txtDestinationController,
                          focusNode: _focusDestination,
                          decoration: const InputDecoration(
                              hintText: "Where to?",
                              fillColor: MyColors.colorLightGrayFair,
                              filled: true,
                              isDense: true,
                              border: InputBorder.none),
                        ),
                      ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
