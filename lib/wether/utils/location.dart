

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
 import 'package:fluttertoast/fluttertoast.dart';



 class UserLocation {
  double? latitude;
  double? longitude;

  // Future<bool> determinePosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         'Location services are disabled. Please enable the services')));
  //     // return false;
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //       // ScaffoldMessenger.of(context).showSnackBar(
  //       //     const SnackBar(content: Text('Location permissions are denied')));
  //       // return false;
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //          'Location permissions are permanently denied, we cannot request permissions.');
      
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //     content: Text(
  //     //         'Location permissions are permanently denied, we cannot request permissions.')));
  //     // return false;
  //   }
  //   return true;
  // }

  // Future<void> _getCurrentPosition() async {
  //   final hasPermission = await determinePosition();

  //   if (!hasPermission) return;
  //   await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
  //       .then((Position position) {
  //         latitude = position.latitude;
  //         longitude = position.longitude;
  //     // setState(() => _currentPosition = position);
  //     // _getAddressFromLatLng(_currentPosition!);
  //   }).catchError((e) {
  //     debugPrint(e);
  //   });
  // }

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

  //  Future<bool> _handleLocationPermission() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: "Location services are disabled. Please Enable the Service");
     
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
         Fluttertoast.showToast(msg: "Location permissions are denied");
        // return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
       Fluttertoast.showToast(msg: "Location permissions are permanently denied, we cannot request permissions.");
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    latitude = position.latitude;
    longitude = position.longitude;
  }
}

