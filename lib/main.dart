

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:smart_agri/Buyer/home.dart';
import 'package:smart_agri/firebase_options.dart';
import 'package:smart_agri/homepage.dart';
import 'package:get/get.dart';
import 'package:smart_agri/language.dart';
// import 'package:page_transition/page_transition.dart';
// import 'package:phone_otp/firebase_options.dart';
// import 'package:phone_otp/loginScreen.dart';
import 'package:smart_agri/splash.dart';
// import 'package:phone_verification/loginScreen.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  // Create the initialization Future outside of `build`:
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //  Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(
            child: Text('Could not load app'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            translations: LocaleString(),
           locale: const Locale('en','US'),
            title: 'Smart Agri',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: Color.fromARGB(255, 247, 82, 17),
                // primarySwatch: Color.fromARGB(255, 247, 82, 17),
                inputDecorationTheme: InputDecorationTheme(
                    labelStyle: TextStyle(color: Colors.grey)),
                backgroundColor: Colors.white),
              home: splashscreen(),
                  //  home: introduction(),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  )
                ],
              )
            ]);
      },
    );
  }
}














// import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:smart_agri/firebase_options.dart';
// import 'package:smart_agri/homepage.dart';
// import 'package:smart_agri/phone_otp/registerScreen.dart';




// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );
// runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final Future<FirebaseApp> _initialization = Firebase.initializeApp();

// @override
// Widget build(BuildContext context) {
// 	return MaterialApp(
// 	title: 'Smart Agri',
// 	theme: ThemeData(
// 		            primaryColor: Color.fromARGB(255, 211, 81, 5),
//                 // primarySwatch: Color.fromARGB(255, 211, 81, 5),
// 	),
// 	home: MyHomePage(),
// 	debugShowCheckedModeBanner: false,
// 	);
// }
// }

// class MyHomePage extends StatefulWidget {
// @override
// Widget build(BuildContext context) {
// 	return MaterialApp(
// 	title: 'Smart Agri',
// 	debugShowCheckedModeBanner: false,
// 	);
// }

// @override
// _MyHomePageState createState() => _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> {
// @override
// void initState() {
// 	super.initState();
// 	Timer(Duration(seconds: 3),
// 		()=>Navigator.pushReplacement(context,
// 										MaterialPageRoute(builder:
// 														(context) =>
// 														 RegisterScreen()
//                             // introduction()
// 														)
// 									)
// 		);
// }
// @override
// Widget build(BuildContext context) {
//   	return Stack(
//           children: [
//             Container(
//                 // height: 600,
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: const AssetImage('assets/dashboard.png'),
//                     fit: BoxFit.fill,
//                     // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.modulate,)
//                   )
//                 ),
//             ),
//              Center(
//                child: Container(
//                   // padding: EdgeInsets.only(
//                   //     top: MediaQuery.of(context).size.height * 10),
//                child: Column(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // alignment: Alignment.center,
//                        SizedBox(height: 220,),
//                   Container(
//                     // alignment: Alignment.center,
//                     height: 165,
//                     width: 280,
//                     // padding: EdgeInsets.only(
//                     //     top: MediaQuery.of(context).size.height * 0.5),
//                          decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image:  AssetImage('assets/splash_logo.png',),
//                          fit: BoxFit.fitWidth,
//                         // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.modulate,)
//                       )
//                     ),
//                     // child: new Text('SMART AGRI ADVISORY SERVICE',)
//                         ),
//                         Container(
//                           alignment: Alignment.center,
//                           child: Text("SMART AGRI ADVISORY SERVICE", style: TextStyle(fontSize: 16,color: Colors.white,decoration: TextDecoration.none),
//                           ),  
//                           // child:  Text('SMART AGRI ADVISORY SERVICE',)
//                         )
//           ]),
//                 ),
//              )]);
//                     //))]);
// // 
// // Container(
// // 	color: Colors.white,
// // 	child:FlutterLogo(size:MediaQuery.of(context).size.height)
// // 	);
// // }
// // }
// // class SecondScreen extends StatelessWidget {
// // @override
// // Widget build(BuildContext context) {
// // 	return Scaffold(
// // 	appBar: AppBar(title:Text("GeeksForGeeks")),
// // 	body: Center(
// // 		child:Text("Home page",textScaleFactor: 2,)
// // 	),
// // 	);
// }
// }
