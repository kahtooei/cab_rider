// ignore_for_file: prefer_final_fields

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cab_rider/UI/Screens/main/widgets/drawer_widget.dart';
import 'package:cab_rider/UI/widgets/my_custom_buttom.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_status.dart';
import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/repository/models/direction.dart';
import 'package:cab_rider/shared/resources/user_data.dart';
import 'package:cab_rider/shared/utils/colors.dart';
import 'package:cab_rider/shared/utils/page_routes.dart';
import 'package:cab_rider/shared/utils/show_snackbar.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double mapPadding = 350;
  bool isEstimateState = false;
  double searchPanelHeight =
      300; // first panel show by default and hide after get directions
  double estimatePanelHeight =
      0; // this panel show after directions with height 250
  double requestPanelHeight =
      0; // this panel show after request a ride with height 200
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late final GoogleMapController mapController;
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  late Position _currentPosition;
  List<LatLng> _points = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  Map<String, dynamic> estimateDetailsData = {};

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission.name == "denied" || permission.name == "deniedForever") {
      LocationPermission reqPermission = await Geolocator.requestPermission();
      permission = reqPermission;
    }

    if (permission.name == "whileInUse" || permission.name == "always") {
      bool serviceEnabled =
          await _geolocatorPlatform.isLocationServiceEnabled();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MyDrawerWidget(),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: mapPadding, top: 20),
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            polylines: _polylines,
            markers: _markers,
            circles: _circles,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              mapController = controller;

              setState(() {
                mapPadding = 300;
              });
              setCurrentPosition();
            },
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: AnimatedSize(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeIn,
              child: Container(
                height: searchPanelHeight,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black45,
                      blurRadius: 15,
                      spreadRadius: 0.8,
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Nice to see you",
                        style: TextStyle(fontSize: 12),
                      ),
                      const Text(
                        "Where are you going?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, PagesRouteData.searchPage);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 4,
                                    spreadRadius: 0.5,
                                    color: Colors.black26)
                              ]),
                          child: Row(
                            children: const [
                              Icon(
                                Icons.search,
                                color: Colors.black54,
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                "Search Destination",
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListTile(
                        leading: const Icon(Icons.home),
                        // title: const Text("Add Home"),
                        title: BlocBuilder<MainScreenBloc, MainScreenState>(
                          builder: (context, state) {
                            switch (state.currentPosition.runtimeType) {
                              case LoadingMainScreenStatus:
                                return const Text("Add Home");
                              case FailedMainScreenStatus:
                                return const Text("Failed Get Home");
                              case CompleteMainScreenStatus:
                                return Text((state.currentPosition
                                        as CompleteMainScreenStatus)
                                    .address
                                    .placeFormattedAddress!);
                              default:
                                return const Text("");
                            }
                          },
                        ),
                        subtitle: const Text("Your residential address"),
                        onTap: () {},
                      ),
                      const Divider(
                        color: Colors.black38,
                        height: 1,
                      ),
                      ListTile(
                        leading: const Icon(Icons.work),
                        title: const Text("Add Work"),
                        subtitle: const Text("Your office address"),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  isEstimateState
                      ? resetApp()
                      : scaffoldKey.currentState!.openDrawer();
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 15,
                            spreadRadius: 0.5,
                            color: Colors.black54)
                      ]),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      isEstimateState ? Icons.arrow_back : Icons.menu,
                      color: Colors.black87,
                    ),
                  ),
                ),
              )),
          BlocListener<MainScreenBloc, MainScreenState>(
            listenWhen: (previous, current) {
              if (current.routeDirection.runtimeType ==
                      CompleteDirectionsStatus &&
                  current.riderRequest.runtimeType == EmptyRiderRequestStatus) {
                return true;
              }
              return false;
            },
            listener: (context, state) {
              _points.clear();
              _polylines.clear();
              _markers.clear();
              _circles.clear();
              estimateDetailsData = {};
              if (state.routeDirection.runtimeType ==
                  CompleteDirectionsStatus) {
                //update polyline for current directions
                DirectionModel direction =
                    (state.routeDirection as CompleteDirectionsStatus)
                        .direction;
                String encoded_points = direction.encodedPoints!;
                PolylinePoints polylinePoints = PolylinePoints();
                List<PointLatLng> result =
                    polylinePoints.decodePolyline(encoded_points);
                for (PointLatLng point in result) {
                  _points.add(LatLng(point.latitude, point.longitude));
                }
                Polyline polyline = Polyline(
                  polylineId: PolylineId('id'),
                  color: Colors.blue,
                  points: _points,
                  width: 4,
                  jointType: JointType.round,
                  startCap: Cap.roundCap,
                  endCap: Cap.roundCap,
                  geodesic: true,
                );
                _polylines.add(polyline);

                //fitting polyline on map

                AddressModel start =
                    (state.currentPosition as CompleteMainScreenStatus).address;
                AddressModel end =
                    (state.selectedPlaceDetails as CompletePlaceDetailsStatus)
                        .placeDetails;

                LatLngBounds bounds = getBounds(start, end);
                mapController
                    .animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

                //set markers
                Marker startMarker = Marker(
                    markerId: MarkerId('start'),
                    position: LatLng(start.latitude!, start.longitude!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    infoWindow: InfoWindow(
                        title: start.placeFormattedAddress,
                        snippet: 'Pickup Location'));
                Marker endMarker = Marker(
                    markerId: MarkerId('end'),
                    position: LatLng(end.latitude!, end.longitude!),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueRed),
                    infoWindow: InfoWindow(
                        title: end.placeName, snippet: 'Destination Location'));

                _markers.add(startMarker);
                _markers.add(endMarker);

                //set Circles
                Circle startCircle = Circle(
                    circleId: CircleId('start'),
                    strokeWidth: 5,
                    strokeColor: MyColors.colorGreen,
                    radius: 12,
                    center: LatLng(start.latitude!, start.longitude!),
                    fillColor: MyColors.colorGreen);

                Circle endCircle = Circle(
                    circleId: CircleId('end'),
                    strokeWidth: 5,
                    strokeColor: MyColors.colorAccentPurple,
                    radius: 12,
                    center: LatLng(end.latitude!, end.longitude!),
                    fillColor: MyColors.colorAccentPurple);

                _circles.add(startCircle);
                _circles.add(endCircle);

                //show estimate panel
                estimatePanelHeight = 250;
                searchPanelHeight = 0;
                isEstimateState = true;
                setEstimateData(direction);
              }

              setState(() {});
            },
            child: Container(),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AnimatedSize(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  height: estimatePanelHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          spreadRadius: 0.5,
                        )
                      ]),
                  child: Column(
                    children: [
                      Container(
                        decoration:
                            const BoxDecoration(color: MyColors.colorAccent1),
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        margin: const EdgeInsets.only(top: 15, bottom: 20),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/taxi.png",
                              width: 70,
                              height: 70,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Taxi",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  estimateDetailsData['distance'] ?? '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: MyColors.colorTextLight),
                                )
                              ],
                            ),
                            Expanded(child: Container()),
                            Text(
                              "\$${estimateDetailsData['cost'] ?? ''}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: const [
                            Icon(
                              FontAwesomeIcons.moneyBill,
                              size: 18,
                              color: MyColors.colorTextLight,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Cash",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: MyColors.colorTextLight,
                              size: 15,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: MyCustomButton(
                          onPress: sendRequest,
                          title: "REQUEST CAB",
                        ),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AnimatedSize(
                curve: Curves.easeIn,
                duration: const Duration(milliseconds: 150),
                child: BlocConsumer<MainScreenBloc, MainScreenState>(
                  buildWhen: (previous, current) {
                    if (previous.riderRequest.runtimeType ==
                        current.riderRequest.runtimeType) {
                      return false;
                    }
                    return true;
                  },
                  listenWhen: (previous, current) {
                    if (previous.riderRequest.runtimeType ==
                        current.riderRequest.runtimeType) {
                      return false;
                    }
                    return true;
                  },
                  listener: (context, state) {
                    if (state.riderRequest.runtimeType ==
                        EmptyRiderRequestStatus) {
                      cancelRequest();
                    } else if (state.riderRequest.runtimeType ==
                        FailedRiderRequestStatus) {
                      showSnackBar(
                          (state.riderRequest as FailedRiderRequestStatus)
                              .error,
                          context);
                      cancelRequest();
                    }
                  },
                  builder: (context, state) {
                    String message = "";
                    message = state.riderRequest.runtimeType ==
                            CompleteRiderRequestStatus
                        ? "Requesting a Ride..."
                        : state.riderRequest.runtimeType ==
                                LoadingRiderRequestStatus
                            ? "Sending a Request..."
                            : state.riderRequest.runtimeType ==
                                    FailedRiderRequestStatus
                                ? "Error In Sending Request!!!"
                                : "No Request!!!";
                    return Container(
                      height: requestPanelHeight,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black38,
                              blurRadius: 5,
                              spreadRadius: 0.5,
                            )
                          ]),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: TextLiquidFill(
                                text: 'Requesting a Ride...',
                                waveColor: MyColors.colorTextSemiLight,
                                boxBackgroundColor: Colors.white,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                boxHeight: 40.0,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          GestureDetector(
                            onTap: () async {
                              BlocProvider.of<MainScreenBloc>(context)
                                  .add(RemoveRiderRequestEvent());
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(
                                      color: Colors.black26, width: 1)),
                              child: const Icon(Icons.close),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Cancel ride",
                            style: TextStyle(
                                color: MyColors.colorText, fontSize: 14),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )),
        ],
      ),
    );
  }

  LatLngBounds getBounds(AddressModel start, AddressModel end) {
    if (start.latitude! > end.latitude! && start.longitude! > end.longitude!) {
      return LatLngBounds(
          southwest: LatLng(end.latitude!, end.longitude!),
          northeast: LatLng(start.latitude!, start.latitude!));
    } else if (start.latitude! > end.longitude!) {
      return LatLngBounds(
          southwest: LatLng(start.latitude!, start.latitude!),
          northeast: LatLng(end.latitude!, end.longitude!));
    } else if (start.latitude! > end.latitude!) {
      return LatLngBounds(
          southwest: LatLng(end.latitude!, end.longitude!),
          northeast: LatLng(start.latitude!, start.latitude!));
    } else {
      return LatLngBounds(
          southwest: LatLng(start.latitude!, start.latitude!),
          northeast: LatLng(end.latitude!, end.longitude!));
    }
  }

  setCurrentPosition() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition();
      LatLng currentPos =
          LatLng(_currentPosition.latitude, _currentPosition.longitude);
      CameraPosition currentCP = CameraPosition(target: currentPos, zoom: 14);
      mapController.animateCamera(CameraUpdate.newCameraPosition(currentCP));
      BlocProvider.of<MainScreenBloc>(context).add(GetCurrentAddressEvent(
          latitude: _currentPosition.latitude,
          longitude: _currentPosition.longitude));
    } catch (e) {}
  }

  void setEstimateData(DirectionModel direction) {
    // $0.3 : per KM
    // $0.2 : per Minute
    // #3.0 : base
    double perMin = (direction.durationValue! / 60) * 0.2;
    double perKM = (direction.distanceValue! / 1000) * 0.3;
    int total = (perMin + perKM + 3).truncate();
    estimateDetailsData = {
      'distance': direction.distanceText,
      'duration': direction.durationText,
      'cost': total
    };
  }

  sendRequest() {
    BlocProvider.of<MainScreenBloc>(context).add(SendRiderRequestEvent());
    setState(() {
      searchPanelHeight = 0;
      estimatePanelHeight = 0;
      requestPanelHeight = 200;
      isEstimateState = false;
    });
  }

  resetApp() {
    _points.clear();
    _polylines.clear();
    _markers.clear();
    _circles.clear();
    estimateDetailsData = {};
    BlocProvider.of<MainScreenBloc>(context).add(ResetAppEvent());
    estimatePanelHeight = 0;
    searchPanelHeight = 300;
    setState(() {});
    setCurrentPosition();
  }

  cancelRequest() {
    _points.clear();
    _polylines.clear();
    _markers.clear();
    _circles.clear();
    estimateDetailsData = {};
    estimatePanelHeight = 0;
    requestPanelHeight = 0;
    searchPanelHeight = 300;
    setState(() {});
    setCurrentPosition();
  }
}
