import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_agri/Buyer/buyercontact.dart';
import 'package:smart_agri/Buyer/buyerprofile.dart';
import 'package:smart_agri/Buyer/navbar1.dart';
import 'package:smart_agri/Buyer/packages.dart';
import 'package:smart_agri/contactus.dart';
import 'package:smart_agri/location.dart';
import 'package:floating_bottom_bar/animated_bottom_navigation_bar.dart';
import 'package:url_launcher/url_launcher.dart';



  
void main() { 
  runApp(buyer());  }
  
class buyer extends StatelessWidget {  
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      debugShowCheckedModeBanner: false,
      home: Scaffold(  
  
        appBar: AppBar(  
          actions: [
            PopupMenuButton(
              shape: ContinuousRectangleBorder(
         borderRadius: BorderRadius.circular(30),
       ),
               icon: Image.asset('assets/language.png'),
                   // add icon, by default "3 dot" icon
                   // icon: Icon(Icons.book)
                   itemBuilder: (context){
                     return [

                            const PopupMenuItem<int>(
                                value: 1,
                                child: Text("English"),
                            ),

                            const PopupMenuItem<int>(
                                value: 3,
                                child: Text("मराठी"),
                            ),
                        ];
                   },
                   onSelected:(value){
                      if(value == 1){
                          var locale = Locale('en','US');
                          Get.updateLocale(locale);
                      }
                      // else if(value == 2){
                      //   var locale = Locale('hi','IN');
                      //   Get.updateLocale(locale);
                      // }
                      else if(value == 2){
                        var locale = Locale('mr','IN');
                        Get.updateLocale(locale);
                      }
                   }
                   )
                  
    ],
           title:  Text('Home'.tr),
          // centerTitle: true,
          backgroundColor:  Color.fromARGB(255, 211, 81, 5),
  //          leading: IconButton(
  //   icon: const Icon(Icons.arrow_back, color: Colors.white),
  //   onPressed: () => Navigator.of(context).pop(),
  // ), 
          // title: const Text(appTitle),  
          // centerTitle: true,
        ),  
        drawer: NavBar1(),
        body: introductionForm(),  
         bottomNavigationBar: AnimatedBottomNavigationBar(
              bottomBarItems: [
                BottomBarItemsModel(
                  icon: const Icon(Icons.home, size: 25),
                  iconSelected: const Icon(Icons.home,
                      color: Color.fromARGB(255, 211, 81, 5),
                      size: 25),
                  // title: example.Strings.home,
                  // dotColor: example.AppColors.cherryRed,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => buyer()));
                    // log('Home');
                  },
                ),
                 BottomBarItemsModel(
                   icon: ImageIcon(
                   AssetImage("assets/nav_packages.png"),
                      color: Color.fromARGB(255, 0, 0, 0),
                      // color: Color.fromARGB(255, 211, 81, 5),
                        size: 25,
                         ),
                  // icon:
                  //     const Icon(Icons.location_on, size: 25),

                  iconSelected: Icon(Icons.location_on,
                      color: Color.fromARGB(255, 211, 81, 5),
                      size: 25),
                  // title: example.Strings.search,
                  // dotColor: example.AppColors.cherryRed,
                  onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context) => packages()));
                    // log('Search');
                  },
                ),
                BottomBarItemsModel(
                  //         icon: ImageIcon(
                  //  AssetImage("assets/nav_contact_us.png"),
                  //     color: Color.fromARGB(197, 0, 0, 0),
                  //     // color: Color.fromARGB(255, 211, 81, 5),
                  //       size: 25,
                  //        ),
                  icon:
                       Icon(Icons.phone, size: 25,
                        // color: Color.fromARGB(197, 0, 0, 0),
                        ),
                  iconSelected: 
                       Icon(Icons.phone, size: 25,
                       color: Color.fromARGB(255, 211, 81, 5),),
                  // ImageIcon(
                  //  AssetImage("assets/weather1.png"),
                  //   //  color: Colors.white,
                  //    color: Color.fromARGB(255, 211, 81, 5),
                  //       size: 25,
                  //        ),
                  // Icon(Icons.settings,
                  //     color: Color.fromARGB(255, 211, 81, 5),
                  //     size: 25),
                  // title: example.Strings.person,
                  // dotColor: example.AppColors.cherryRed,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => buyercontact()));
                    // log('Profile');
                  },
                ),
                BottomBarItemsModel(
                    icon: const Icon(Icons.person,
                        size: 25),
                    iconSelected: const Icon(Icons.person,
                        color: Color.fromARGB(255, 211, 81, 5),
                        size: 25),
                    // title: example.Strings.settings,
                    // dotColor: example.AppColors.cherryRed,
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => buyerprofile()));
                      // log('Settings');
                    }),
              ],
              bottomBarCenterModel: BottomBarCenterModel(
                centerBackgroundColor:  Color.fromARGB(255, 211, 81, 5),
                // centerBackgroundColor: example.AppColors.cherryRed,
                centerIcon: const FloatingCenterButton( 
                  child: Icon(
                    Icons.add,
                    color: AppColors.white,
                  ),
                ),
                centerIconChild: [
                  FloatingCenterButtonChild(
                    child:  ImageIcon(
                   AssetImage("assets/yt.png"),
                       color: Color.fromARGB(197, 0, 0, 0),
                    //  color: Color.fromARGB(255, 211, 81, 5),
                        size: 25,
                         ),
                    // const Icon(
                    //   Icons.youtube_searched_for_rounded,
                    //   color: AppColors.white,
                    // ),
                    onTap: () => launch('https://www.youtube.com/@smartagritechnology9885'),
                  ),
                  FloatingCenterButtonChild(
                   
                    child: ImageIcon(
                   AssetImage("assets/fb.png"),
                      color: Color.fromARGB(197, 0, 0, 0),
                    //  color: Color.fromARGB(255, 211, 81, 5),
                        size: 20,
                         ),
                    // Icon(
                    //   Icons.home,
                    //   color: AppColors.white,
                    // ),
                    onTap: () => launch('https://www.facebook.com/login/'),
                  ),
                   FloatingCenterButtonChild(
                   
                    child: ImageIcon(
                   AssetImage("assets/web.png"),
                      color: Color.fromARGB(197, 0, 0, 0),
                    //  color: Color.fromARGB(255, 211, 81, 5),
                        size: 20,
                         ),
                    // Icon(
                    //   Icons.home,
                    //   color: AppColors.white,
                    // ),
                     onTap: () => launch('https://smartagri.in/'),
                  ),
                  FloatingCenterButtonChild(
                   
                    child: ImageIcon(
                   AssetImage("assets/ps.png"),
                      color: Color.fromARGB(197, 0, 0, 0),
                    //  color: Color.fromARGB(255, 211, 81, 5),
                        size: 22,
                         ),
                    // Icon(
                    //   Icons.home,
                    //   color: AppColors.white,
                    // ),
                     onTap: () => launch('https://play.google.com/store/apps/details?id=com.prosolstech.smartagri'),
                  ),
                  FloatingCenterButtonChild(
                    child: const Icon(
                      Icons.arrow_downward_rounded,
                      color: AppColors.black,
                    ),
                    // onTap: () => log('Item3'),
                  ),
                ],
              ),
            ),
      ),  
    );  
  }  
}    
class introductionForm extends StatefulWidget {  

  // late DatabaseReference dbRef;

  @override  
  introductionFormState createState() {  
    return introductionFormState();  
  }  
}  
// Create a corresponding State class. This class holds data related to the form.  
class introductionFormState extends State<introductionForm> {  
  bool circleButtonToggle = false;
  @override  
  Widget build(BuildContext context) {  

    return Stack(
          children: [
            Container(
              margin: EdgeInsets.all(20),
            
                 child:SingleChildScrollView(
                  child:Column(
                    children: [
                  Container(
                  child:Row(  
        mainAxisAlignment: MainAxisAlignment.spaceAround,  
          children: [  
            Column(
              children:[
            InkWell(
              onTap:(){
                 Navigator.push(context, MaterialPageRoute(builder: (context) => buyerprofile()));
              },
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/profile.png',
                    width:55, height: 55),
              ),
              SizedBox(height: 5,),
              Text(
                'Profile'.tr,
                style:
                    TextStyle(fontSize: 14,),
              ),
              ]),
                Column(
              children:[
            InkWell(
              onTap:(){},
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/packages.png',
                    width:55, height: 55),
              ),
              SizedBox(height: 5,),
              Text(
                'Packages',
                style:
                    TextStyle(fontSize: 14,),
              ),
              ]),
             
              Column(
              children:[
            InkWell(
              onTap:(){},
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/marketing.png',
                    width:55, height: 55),
              ),
              SizedBox(height: 5,),
              Text(
                'Marketing'.tr,
                style:
                    TextStyle(fontSize: 14,),
              ),
              ]),
             Column(
              children:[
            InkWell(
              onTap:(){},
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/contact_us.png',
                    width:55, height: 55),
              ),
              SizedBox(height: 5,),
              Text(
                'Contact Us'.tr,
                style:
                    TextStyle(fontSize: 14,),
              ),
              ]),
  
      ]), ) ,
      
                  ])
        ),)
]);}}



// import 'dart:async';
// import 'package:flutter/material.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Timer(
//     //     Duration(seconds: 3),
//     //     () => Navigator.of(context).pushReplacement(MaterialPageRoute(
//     //         builder: (BuildContext context) => HomeScreen()))
//     //         );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset('assets/dashboard.png'),
//       ),
//     );
//   }
// }