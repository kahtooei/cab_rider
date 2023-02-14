import 'package:cab_rider/UI/Screens/main/widgets/prediction_list_item.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_status.dart';
import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/shared/utils/colors.dart';
import 'package:cab_rider/shared/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
                          onChanged: (txt) {
                            if (txt.isNotEmpty) {
                              BlocProvider.of<MainScreenBloc>(context)
                                  .add(GetPredictionsListEvent(name: txt));
                            }
                          },
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
            ),
            Expanded(
              child: BlocConsumer<MainScreenBloc, MainScreenState>(
                builder: (context, state) {
                  print("#### RUN BUILDER ####");
                  switch (state.predictionsList.runtimeType) {
                    case LoadingPredictionsStatus:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    case FailedPredictionsStatus:
                      return const Center(
                        child: Text("Failed"),
                      );
                    case CompletePredictionsStatus:
                      return ListView.builder(
                        itemCount:
                            (state.predictionsList as CompletePredictionsStatus)
                                .predictionsList
                                .length,
                        itemBuilder: (context, index) {
                          return PredictionListItem((state.predictionsList
                                  as CompletePredictionsStatus)
                              .predictionsList[index]);
                        },
                      );
                    default:
                      return Container();
                  }
                },
                listener: (context, state) {
                  print("#### RUN LISTENER ####");
                  if (state.selectedPlaceDetails.runtimeType ==
                          CompletePlaceDetailsStatus &&
                      state.currentPosition.runtimeType ==
                          CompleteMainScreenStatus) {
                    print("===FIRST-IF===");
                    if (state.routeDirection.runtimeType ==
                        CompleteDirectionsStatus) {
                      print("--------------------");
                      print("DIRECTION COMPLETED");
                      print("--------------------");
                      Navigator.pop(context);
                      Navigator.pop(context);
                    } else if (state.routeDirection.runtimeType ==
                        EmptyDirectionsStatus) {
                      print("++++++++++++++++++++");
                      print("GET DIRECTION");
                      print("++++++++++++++++++++");
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const ProgressDialog("Get Direction..."));
                      AddressModel start =
                          (state.currentPosition as CompleteMainScreenStatus)
                              .address;
                      AddressModel end = (state.selectedPlaceDetails
                              as CompletePlaceDetailsStatus)
                          .placeDetails;
                      BlocProvider.of<MainScreenBloc>(context).add(
                          GetRouteDirectionEvent(
                              startPosition:
                                  LatLng(start.latitude!, start.longitude!),
                              endPosition:
                                  LatLng(end.latitude!, end.longitude!)));
                    } else {}
                  } else {
                    print("===SECOND-IF===");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
