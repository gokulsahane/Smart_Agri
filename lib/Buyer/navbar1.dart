import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_agri/Buyer/buyercontact.dart';
import 'package:smart_agri/Buyer/buyerprofile.dart';
import 'package:smart_agri/Buyer/packages.dart';
import 'package:smart_agri/phone_otp/loginScreen.dart';

class NavBar1 extends StatefulWidget {
  NavBar1({Key? key}) : super(key: key);
    @override
  _NavBar1State createState() => _NavBar1State();
}

class _NavBar1State extends State<NavBar1> {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  User? users = FirebaseAuth.instance.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 var userName= '';
var userEmail = '';
var userType = '';
var PhNumber='';
String? village='';
String? PlotArea='';
      
        @override
   void initState() {
    getUser();
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(137, 0, 0, 0),
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
           Center(
             child: Container(
             
       width: 100,
      height: 150,
      color: Color.fromARGB(29, 0, 0, 0),
          child:  DrawerHeader(
             
               child: Text("$userName",style: TextStyle(color: Colors.white),),
               
                // decoration: BoxDecoration(
                //    color: Color.fromARGB(29, 0, 0, 0),
                //   image: DecorationImage(
                //     image: AssetImage("assets/profile.png"),
                //        fit: BoxFit.scaleDown)
                // ),
                 margin: EdgeInsets.only(top:50),
              ),
          ),
           ),

          ListTile(
            title: Text('My Profile'.tr,style: TextStyle(color: Colors.white,),),
             leading: ImageIcon(
     AssetImage("assets/nav_my_profile.png",),
      color: Colors.white,
      size: 22,
      // color: Color.fromARGB(255, 90, 88, 88),
     ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => buyerprofile()));
            }
          ),
          ListTile(
            title: Text('Packages'.tr,style: TextStyle(color: Colors.white),),
           leading:const ImageIcon(
     AssetImage("assets/nav_packages.png"),
     color: Colors.white,
      size: 22,
     ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => packages()));
            }
          ),
          ListTile(
            title: Text('Marketing'.tr,style: TextStyle(color: Colors.white),),
           leading:const ImageIcon(
     AssetImage("assets/nav_marketing.png"),
     color: Colors.white,
      size: 22,
     ),
            // onTap: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context) => way()));
            // }
          ),
          
ListTile(
            title: Text('Contact Us'.tr,style: TextStyle(color: Colors.white),),
           leading:const ImageIcon(
     AssetImage("assets/nav_contact_us.png"),
     color: Colors.white,
      size: 22,
     ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => buyercontact()));
            }
          ),
          
          ListTile(
            title: Text('Sign Out',style: TextStyle(color: Colors.white),),
    //        leading:const ImageIcon(
    //  AssetImage("assets/list_icon.png"),
    //  color: Colors.white,
    //   size: 22,
    //  ),
    leading: Icon(Icons.login,color:Colors.white,),
            onTap: (){
              signOut();
            }
          ),


          
        ],
      ),
    );
  }
   signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,MaterialPageRoute
    (builder: (BuildContext context) => LoginScreen())));
  }
  void getUser() async {
    User? user = FirebaseAuth.instance.currentUser;
//  User user = _firebaseAuth.currentUser;
  if (_auth.currentUser != null) {
      var PhoneNumber = _auth.currentUser!.phoneNumber;
      PhoneNumber =
          '0${_auth.currentUser!.phoneNumber!.substring(3, PhoneNumber!.length)}';
      debugPrint(PhoneNumber);
      await _firestore
  // FirebaseFirestore.instance
  .collection('users').doc(user!.uid).snapshots().listen((_firestore) {
 
    setState(() {
      userName = _firestore.data()!['Name'];
        userEmail = _firestore.data()!['EmailID'];
       userType = _firestore.data()!['UserType'];
       PhNumber = _firestore.data()!['PhoneNumber'];
       village = _firestore.data()!['User_Village'];
        PlotArea = _firestore.data()!['User_Plot'];
      
    }
    );
    });
  }
  }
}