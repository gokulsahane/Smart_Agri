import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_agri/firebase_options.dart';
import 'package:smart_agri/homepage.dart';
import 'package:smart_agri/phone_otp/loginScreen.dart';
import 'package:smart_agri/phone_otp/registerScreen.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );
runApp(splashscreen());
}

class splashscreen extends StatelessWidget {

@override
Widget build(BuildContext context) {
	return MaterialApp(
	title: 'Smart Agri',
	theme: ThemeData(
		            primaryColor: Color.fromARGB(255, 211, 81, 5),
                // primarySwatch: Color.fromARGB(255, 211, 81, 5),
	),
	home: MyHomePage(),
	debugShowCheckedModeBanner: false,
	);
}
}

class MyHomePage extends StatefulWidget {
@override
Widget build(BuildContext context) {
	return MaterialApp(
	title: 'Smart Agri',
	debugShowCheckedModeBanner: false,
	);
}

@override
_MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
@override
void initState() {
	super.initState();
	Timer(Duration(seconds: 3),
		()=>Navigator.pushReplacement(context,
										MaterialPageRoute(builder:
														(context) =>
														 LoginScreen()
                            // introduction()
														)
									)
		);
}
@override
Widget build(BuildContext context) {
  	return Stack(
          children: [
            Container(
                // height: 600,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: const AssetImage('assets/dashboard.png'),
                    fit: BoxFit.fill,
                    // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.modulate,)
                  )
                ),
            ),
             Center(
               child: Container(
                  // padding: EdgeInsets.only(
                  //     top: MediaQuery.of(context).size.height * 10),
               child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // alignment: Alignment.center,
                       SizedBox(height: 220,),
                  Container(
                    // alignment: Alignment.center,
                    height: 165,
                    width: 280,
                    // padding: EdgeInsets.only(
                    //     top: MediaQuery.of(context).size.height * 0.5),
                         decoration: BoxDecoration(
                      image: DecorationImage(
                        image:  AssetImage('assets/splash_logo.png',),
                         fit: BoxFit.fitWidth,
                        // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.modulate,)
                      )
                    ),
                    // child: new Text('SMART AGRI ADVISORY SERVICE',)
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text("SMART AGRI ADVISORY SERVICE", style: TextStyle(fontSize: 16,color: Colors.white,decoration: TextDecoration.none),
                          ),  
                          // child:  Text('SMART AGRI ADVISORY SERVICE',)
                        )
          ]),
                ),
             )]);
                    //))]);
// 
// Container(
// 	color: Colors.white,
// 	child:FlutterLogo(size:MediaQuery.of(context).size.height)
// 	);
// }
// }
// class SecondScreen extends StatelessWidget {
// @override
// Widget build(BuildContext context) {
// 	return Scaffold(
// 	appBar: AppBar(title:Text("GeeksForGeeks")),
// 	body: Center(
// 		child:Text("Home page",textScaleFactor: 2,)
// 	),
// 	);
}
}
