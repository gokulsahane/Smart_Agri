import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:smart_agri/homepage.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Set Location"),
      backgroundColor: const Color.fromARGB(255, 247, 82, 17),
        leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => introduction()))
  ),
      ),
      body: SafeArea(
        child: Center(
          child:Container(
             margin: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('LATITUDE: ${_currentPosition?.latitude ?? ""}',style: TextStyle(fontSize: 15,)),
              SizedBox(height: 10,),
              Text('LONGITUDE: ${_currentPosition?.longitude ?? ""}',style: TextStyle(fontSize: 15,)),
              SizedBox(height: 10,),
              Text('ADDRESS: ${_currentAddress ?? ""}',style: TextStyle(fontSize: 15,)),
               SizedBox(height: 32),
              FloatingActionButton.extended(
             onPressed: _getCurrentPosition,
                       backgroundColor: const Color.fromARGB(255, 247, 82, 17),
           label:  Text("DETECT MY LOCATION"),
          ),
          SizedBox(height: 32),
           FloatingActionButton.extended(
             onPressed: (){},
            //  _getCurrentPosition,
                       backgroundColor: const Color.fromARGB(255, 247, 82, 17),
           label:  Text("Save Address"),
          ),
              // ElevatedButton(
              //   onPressed: _getCurrentPosition,
              //   child: const Text("Get Current Location"),
              // )
            ],
          ),
        ),
      ),),
    );
  }
}








// import 'package:flutter/material.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';

// class LocationPage extends StatefulWidget {
//    LocationPage({Key? key}) : super(key: key);

//   @override
//   State<LocationPage> createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   String? _currentAddress;
//   Position? _currentPosition;

//   Future<bool> _handleLocationPermission() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location services are disabled. Please enable the services')));
//       return false;
//     }
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Location permissions are denied')));
//         return false;
//       }
//     }
//     if (permission == LocationPermission.deniedForever) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text(
//               'Location permissions are permanently denied, we cannot request permissions.')));
//       return false;
//     }
//     return true;
//   }

//   Future<void> _getCurrentPosition() async {
//     final hasPermission = await _handleLocationPermission();

//     if (!hasPermission) return;
//     await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
//         .then((Position position) {
//       setState(() => _currentPosition = position);
//       _getAddressFromLatLng(_currentPosition!);
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   Future<void> _getAddressFromLatLng(Position position) async {
//     await placemarkFromCoordinates(
//             _currentPosition!.latitude, _currentPosition!.longitude)
//         .then((List<Placemark> placemarks) {
//       Placemark place = placemarks[0];
//       setState(() =>
//         _currentAddress =
//             '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}');
    
//     }).catchError((e) {
//       debugPrint(e);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Location Page"),
//       backgroundColor: Color.fromARGB(255, 247, 82, 17),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 200,),
//               FloatingActionButton.extended(
//              onPressed: _getCurrentPosition,
//                        backgroundColor: const Color.fromARGB(255, 247, 82, 17),
//            label:  Text("DETECT MY LOCATION"),
//           ),
//           SizedBox(height: 20,),
         
         
//               Text('LATITUDE: ${_currentPosition?.latitude ?? ""}',style: TextStyle(fontSize: 15,),),
//               SizedBox(height: 20,),
//               Text('LONGITUDE: ${_currentPosition?.longitude ?? ""}',style: TextStyle(fontSize: 15,),),
//               SizedBox(height: 20,),
//               Text('ADDRESS: ${_currentAddress ?? ""}',style: TextStyle(fontSize: 15,),),
//                SizedBox(height: 20),
//                FloatingActionButton.extended(
//              onPressed: (){
//              },
//                        backgroundColor:  Color.fromARGB(255, 247, 82, 17),
//            label:  Text("SAVE"),
//           ),
//               // ElevatedButton(
//               //   onPressed: _getCurrentPosition,
//               //   child: const Text("Get Current Location"),
//               // )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
