import 'package:cab_rider/UI/Screens/main/widgets/drawer_widget.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_bloc.dart';
import 'package:cab_rider/bloc/main_screen_bloc/main_screen_status.dart';
import 'package:cab_rider/repository/models/address.dart';
import 'package:cab_rider/shared/utils/colors.dart';
import 'package:cab_rider/shared/utils/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  double mapPadding = 350;
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
            child: Container(
              height: 300,
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, PagesRouteData.searchPage);
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
          Positioned(
              top: 40,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  scaffoldKey.currentState!.openDrawer();
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
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.menu,
                      color: Colors.black87,
                    ),
                  ),
                ),
              )),
          BlocListener<MainScreenBloc, MainScreenState>(
            listenWhen: (previous, current) {
              if (current.routeDirection.runtimeType ==
                  CompleteDirectionsStatus) {
                return true;
              }
              return false;
            },
            listener: (context, state) {
              _points.clear();
              _polylines.clear();
              _markers.clear();
              _circles.clear();
              if (state.routeDirection.runtimeType ==
                  CompleteDirectionsStatus) {
                //update polyline for current directions
                String encoded_points =
                    (state.routeDirection as CompleteDirectionsStatus)
                        .direction
                        .encodedPoints!;
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
              }

              setState(() {});
            },
            child: Container(),
          ),
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
}
