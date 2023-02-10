import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_agri/phone_otp/loginScreen.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:phone_verification/loginScreen.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// var userName= '';
// var userEmail = '';
// var userAccountType = '';

class LoggedInScreen extends StatefulWidget {
   LoggedInScreen({Key? key}) : super(key: key);
  // LoggedInScreen({required this.users});

  @override
  _LoggedInScreenState createState() => _LoggedInScreenState();
}

class _LoggedInScreenState extends State<LoggedInScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? users = FirebaseAuth.instance.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var userName= '';
var userEmail = '';
var userType = '';

  @override
   void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(height: 50,),
          Text(
            'Welcome  $userName $userEmail $userType' + userName,
            // style: TextStyle(fontSize: 30),
          ),
          Text('(cellnumber: ' +
              (_auth.currentUser!.phoneNumber ?? '') +
              ' uid:' +
              (_auth.currentUser!.uid != null ? _auth.currentUser!.uid : '') +
              ')'),
          ElevatedButton(
              onPressed: () => {
                    //sign out
                    signOut()
                  },
              child: Text('Sign out'))
        ],
      ),
    ));
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
      
    }
    );
    });
  }
  }

  //  Future getUser() async {
  //    User? user = FirebaseAuth.instance.currentUser;
  //   // User user = _firebaseAuth.currentUser;
  //   if (_auth.currentUser != null) {
  //     var PhoneNumber = _auth.currentUser!.phoneNumber;
  //     PhoneNumber =
  //         '0' + _auth.currentUser!.phoneNumber!.substring(3, PhoneNumber!.length);
  //     debugPrint(PhoneNumber);
  //     await _firestore
  //         .collection('users')
  //         // .where('PhoneNumber', isEqualTo: PhoneNumber)
  //         .snapshots()
  //         .listen((_firestore) {
  //           userName = _firestore.docs[0].data()['Name'];
  //       userEmail = _firestore.docs[0].data()['EmailID'];
  //      userAccountType = _firestore.docs[0].data()['AccountType'];
  //         });
  //     //     .get()
  //     //     .then((result) {
  //     //   if (result.docs.length > 0) {
  //     //     setState(() {
  //     //       userName = result.docs[0].data()['Name'];
  //     //   userEmail = result.docs[0].data()['EmailID'];
  //     //  userAccountType = result.docs[0].data()['AccountType'];
  //     //       //  userName = _firestore.data()['Name'];
  //     //       // // _userName = result.data['UserName'].toString();
  //     //       // userName = result.docs[0].data()['Name'];
  //     //       // userEmail = result.docs[0].data()['EmailID'].toString();
  //     //       // userAccountType = result.docs[0].data()['AccountType'].toString();
  //     //     });
  //     //   }
  //     // });
  //   }
  // }

  // Future getUser() async {
  //   // User user = _firebaseAuth.currentUser;
  //   if (_auth.currentUser != null) {
  //     var cellNumber = _auth.currentUser!.phoneNumber;
  //     cellNumber =
  //         '0' + _auth.currentUser!.phoneNumber!.substring(3, cellNumber!.length);
  //     debugPrint(cellNumber);
  //     await _firestore
  //         .collection('users')
  //         .where('PhoneNumber', isEqualTo: cellNumber)
  //         .get()
  //         .then((result) {
  //       if (result.docs.length > 0) {
  //         setState(() {
  //           userName = result.docs[0].data()['Name'];
  //       userEmail = result.docs[0].data()['EmailID'];
  //      userType = result.docs[0].data()['UserType'];
  //         });
  //       }
  //     });
  //   }
  // }

  signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => LoginScreen())));
  }
}
