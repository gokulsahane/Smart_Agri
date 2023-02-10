import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_agri/Buyer/home.dart';
import 'package:smart_agri/homepage.dart';
import 'package:smart_agri/phone_otp/loginScreen.dart';
import 'package:smart_agri/profile_picture/screens/select_photo_options_screen.dart';
// import '../widgets/common_buttons.dart';
// import '../constants.dart';
// import 'select_photo_options_screen.dart';

class buyerprofile extends StatefulWidget {
   buyerprofile({Key? key}) : super(key: key);
      // profile({super.key});

    //  static const id = 'set_photo_screen';
  
  @override
  buyerprofileState createState() => buyerprofileState();
}

class buyerprofileState extends State<buyerprofile> {
   TextEditingController UserName = TextEditingController();
  TextEditingController UserMobileNumber = TextEditingController();
  TextEditingController UserVillage = TextEditingController();
  TextEditingController UserEmail = TextEditingController();
  TextEditingController UserPlotArea = TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? users = FirebaseAuth.instance.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 var userName= '';
var userEmail = '';
var userType = '';
var PhNumber='';
 String? village='';
String? PlotArea='';

  File? _image;
   String? countryValue;
   String? stateValue;
   String? cityValue;
   late bool success;

    @override
   void initState() {
    getUser();
    super.initState();
  }

   Future _pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        _image = img;
        Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: SelectPhotoOptionsScreen(
                onTap: _pickImage,
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(  
           title:  Text('My Profile'),
          // centerTitle: true,
          backgroundColor:  const Color.fromARGB(255, 247, 82, 17),
           leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => buyer()))
  ), 
    actions: [
            Container(
              margin:  EdgeInsets.all(10),
            child:TextButton(
                    style: TextButton.styleFrom(
      backgroundColor: Colors.white,
    ),
              child:Text("Log Out",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => signOut()));
                // calendarController.clearSelectedDates();
              },
              // icon: const Icon(Icons.clear),
            ))
          ],
  ),
      body:
        SafeArea(
          child: SingleChildScrollView(
            child:Container(
               margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,  
              children:[
                SizedBox(height: 30,),
                GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        _showSelectPhotoOptions(context);
                      },
                child:Container(
                  child:Center(
                    //  child: GestureDetector(
                    //   behavior: HitTestBehavior.translucent,
                    //   onTap: () {
                    //     _showSelectPhotoOptions(context);
                    //   },
            child: Container(
              height: 110,
              width: 110,
              decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              // color: Colors.grey.shade200,
                            ),
                            child: Center(
                              child: _image == null
                                   ?
          CircleAvatar(radius: (52),
              backgroundColor: Colors.white,
              child: ClipRRect(
                borderRadius:BorderRadius.circular(50),
                child: Image.asset("assets/profile.png"),
              )
          )
                                  // const Text(
                                  //     'No image selected',
                                  //     style: TextStyle(fontSize: 20),
                                  //   )
                                  : CircleAvatar(
                                      backgroundImage: FileImage(_image!),
                                      radius: 200.0,
                                    ),
                            )
           )
    )),),
    SizedBox(height: 10,),
    // GestureDetector(
    //                   behavior: HitTestBehavior.translucent,
    //                   onTap: () {
    //                     _showSelectPhotoOptions(context);
    //                   },
   Container(
      child:Center(
      child: Container(
          child: Text("UPLOAD/CHANGE/REMOVE"),
      ),
    )),
     SizedBox(height: 10,),
    Container(
      child:Center(
      // child: Container(
       child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
  Text("ACCOUNT TYPE:"),
  Text('  $userType', style: const TextStyle(fontWeight: FontWeight.bold))
]
),
          // child: Text('ACCOUNT TYPE: $userType'+userType),
      ),
    // )
    ),
    SizedBox(height: 20,),
    
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: ImageIcon(
     AssetImage("assets/user.png",),
      color: Colors.black,
      size: 22,
     ),
                              ),
                              Expanded(
                                child: TextField(
                                  // readOnly: true,
                                //  child:Text($userName),
                                    controller: UserName,
                                  cursorColor: Colors.black,
                                 
                                   decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: '$userName',
                                   labelStyle: TextStyle(
                                           color: Colors.black, //<-- SEE HERE
                                    ),
                                  hintStyle: const TextStyle(color: Colors.black),
                                  // border: OutlineInputBorder(
                                    
                                  // )
                                  ),),),
                            ],
                          ),
                           SizedBox(height: 20,),
    
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: ImageIcon(
     AssetImage("assets/mobile.png",),
      color: Colors.black,
      size: 22,
     ),
                              ),
                              Expanded(
                                child: TextField(
                                   readOnly: true,
                                  controller: UserMobileNumber,
                                  cursorColor: Colors.black,
                                 
                                   decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: '$PhNumber',
                                   labelStyle: TextStyle(
                                           color: Colors.black, //<-- SEE HERE
                                    ),
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    
                                  )),),),
                            ],
                          ),
                           SizedBox(height: 20,),
    
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: ImageIcon(
     AssetImage("assets/address.png",),
      color: Colors.black,
      size: 22,
     ),
                              ),
                              Text("FULL ADDRESS",style: TextStyle(fontWeight: FontWeight.w600),),
                            ],
                          ),
                           SizedBox(height: 5,),
                           Container(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            height: 160,
                            child: 
           Column(
            children: [
                             SelectState(
                // style: TextStyle(color: Colors.red),
                onCountryChanged: (value) {
                setState(() {
                  countryValue = value;
                });
              },

             onStateChanged:(value) {
                setState(() {
                  stateValue = value;
                });
              },
               onCityChanged:(value) {
                setState(() {
                  cityValue = value;
                });
              },
              
              ),
                ])  ),
    
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: ImageIcon(
     AssetImage("assets/address.png",),
      color: Colors.black,
      size: 22,
     ),
                              ),
                              Expanded(
                                child: TextField(
                                   controller: UserVillage,
                                  cursorColor: Colors.black,
                                 
                                   decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: village==null ? "Village" :"$village",
                                   labelStyle: TextStyle(
                                           color: Colors.black, //<-- SEE HERE
                                    ),
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    
                                  )),),),
                            ],
                          ),
                           SizedBox(height: 20,),
    
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: ImageIcon(
     AssetImage("assets/email.png",),
      color: Colors.black,
      size: 22,
     ),
                              ),
                              Expanded(
                                child: TextField(
                                  // readOnly: true,
                                    controller: UserEmail,
                                  cursorColor: Colors.black,
                                 
                                   decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: "$userEmail",
                                   labelStyle: TextStyle(
                                           color: Colors.black, //<-- SEE HERE
                                    ),
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    
                                  )),),),
                            ],
                          ),
                           SizedBox(height: 20,),
    
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: ImageIcon(
     AssetImage("assets/plot_area.png",),
      color: Colors.black,
      size: 22,
     ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: UserPlotArea,
                                  cursorColor: Colors.black,
                                 
                                   decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  hintText: PlotArea==null?"TOTAL PLOT AREA (Acres)":"$PlotArea",
                                  //  ==null?"$PlotArea":  "TOTAL PLOT AREA (Acres)",
                                   labelStyle: TextStyle(
                                           color: Colors.black, //<-- SEE HERE
                                    ),
                                  hintStyle: const TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                    
                                  )),),),
                            ],
                          ),
                          SizedBox(height: 30,),

                           Row(
                               mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child:
            FloatingActionButton.extended(
               onPressed: ()  {
                setState(() {
                    var User_Name = userName;
                    var User_MobileNumber= PhNumber;
                    var User_Country = countryValue;
                    var User_State = stateValue;
                    var User_City = cityValue;
                    var User_Village = UserVillage.text;
                     var User_Email = userEmail;
                    var User_Plot = UserPlotArea.text;
                     var User_Image = _image;
                    //  File imageFile = File(_image!.path);
                    user( 
                       User_Name, User_MobileNumber,  User_Email,
                       User_Country, User_State, User_City, 
                       User_Village, User_Plot, User_Image);
                    // FirebaseStorage.instance.ref(uId).putFile(File(_image!.path));
                },
                );
               },
                         backgroundColor: const Color.fromARGB(255, 247, 82, 17),
             label:  Text("Update"),
            ),)
            // FloatingActionButton.extended(
            //    onPressed: ()  {},
            //              backgroundColor: const Color.fromARGB(255, 247, 82, 17),
            //  label:  Text("Cancel"),
            // ),
            ]),
            SizedBox(height: 20,)
              
            ])),),
        ));}

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

   signOut() {
    //redirect
    _auth.signOut().then((value) => Navigator.pushReplacement(context,MaterialPageRoute
    (builder: (BuildContext context) => LoginScreen())));
  }


  

         Future<void> user(
           User_Name, User_MobileNumber, User_Email,
         User_Country, User_State, 
         User_City, User_Village, User_Plot, User_Image) 
         async {
    print("Added");
    CollectionReference _firestore =
        FirebaseFirestore.instance.collection('users');
    // String uId = DateTime.now().microsecondsSinceEpoch.toString();
    //  FirebaseStorage.instance.ref(uId).putFile(File(_image!.path));
    // return Donation.add({'uId': uId, 'Name': Name});

     return await 
          _firestore
        .doc(_auth.currentUser!.uid)
        .set({
                  'Name':User_Name, 'PhoneNumber': User_MobileNumber, 'EmailID':User_Email,
                 'User_Country': User_Country,
                 'User_State':User_State,'User_City':User_City,'User_Village':User_Village,
                 'User_Plot':User_Plot, 
        //  'User_Image':User_Image,
         },
         SetOptions(merge: true)
        )
        .then((value) => {
          Fluttertoast.showToast(msg: "Profile Update Successfully")
              // CherryToast.success(
              //    toastPosition: Position.bottom,
              //    autoDismiss: false,
              //   // displayIcon: success,
              //   displayCloseButton: true,
              //   title: Text('Profile Update Successfully'),
              //   borderRadius: 15,
              // ).show(context),
              // clearText()
            },
            );
        // _onAlertWithCustomContentPressed(context));
          // context: context,
              // builder: 
              // (BuildContext context) => _onAlertWithCustomContentPressed(context),));
        // Navigator.push(
        //     context, MaterialPageRoute(builder: ((context) => MyApp()))))
        // .onError((error, stackTrace) => print("Error")));
   }}
        
      
        // // reverse:true,
        // child: ConstrainedBox(
        //   constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        //   child: Column(
        //     children: [
        //       Expanded(
        //         // flex: 3,
        //         child: Container(
        //           height: 60,
        //           width: 60,
        //           decoration: const BoxDecoration(
        //             image: DecorationImage(
        //                 image: AssetImage("assets/profile.png",),
        //                 fit: BoxFit.fitWidth,
        //                 alignment: Alignment.bottomCenter),
        //           ),
        //         ),
        //       ),
        //       Expanded(
        //         // flex: 4,
        //         child: Padding(
        //           padding: const EdgeInsets.symmetric(horizontal: 1),
        //           child: Column(
        //             children: [
        //               // Row(
        //               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //               //   children: [
        //               //     Text(
        //               //       "SIGN IN",
        //               //       style: Theme.of(context).textTheme.headline4,
        //               //     ),
        //               //     Text(
        //               //       "SIGN UP",
        //               //       style: Theme.of(context).textTheme.button,
        //               //     )
        //               //   ],
        //               // ),
        //               // const Spacer(),
        //               Padding(
        //                 padding: const EdgeInsets.only(bottom: 30),
        //                 child: Row(
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   children: const [
        //                     Padding(
        //                       padding: EdgeInsets.only(right: 8.0),
        //                       child: Icon(
        //                         Icons.alternate_email,
        //                         // color: kPrimaryColor,
        //                       ),
        //                     ),
        //                     Expanded(
        //                       child: TextField(
        //                         decoration:
        //                             InputDecoration(hintText: "Email Address"),
        //                       ),
        //                     )
        //                   ],
        //                 ),
        //               ),
        //               Row(
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: const [
        //                   Padding(
        //                     padding: EdgeInsets.only(right: 8.0),
        //                     child: Icon(
        //                       Icons.lock,
        //                       // color: kPrimaryColor,
        //                     ),
        //                   ),
        //                   Expanded(
        //                     child: TextField(
        //                       decoration: InputDecoration(hintText: "Password"),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //               const Spacer(),
        //               Padding(
        //                 padding: const EdgeInsets.only(bottom: 30),
        //                 child: Row(
        //                   children: [
        //                     Container(
        //                       padding: const EdgeInsets.all(16),
        //                       decoration: BoxDecoration(
        //                         shape: BoxShape.circle,
        //                         border:
        //                             Border.all(color: Colors.white.withOpacity(0.5)),
        //                       ),
        //                       child: Icon(Icons.android,
        //                           color: Colors.white.withOpacity(0.5)),
        //                     ),
        //                     const SizedBox(width: 16),
        //                     Container(
        //                       padding: const EdgeInsets.all(16),
        //                       decoration: BoxDecoration(
        //                         shape: BoxShape.circle,
        //                         border:
        //                             Border.all(color: Colors.white.withOpacity(0.5)),
        //                       ),
        //                       child: Icon(Icons.chat,
        //                           color: Colors.white.withOpacity(0.5)),
        //                     ),
        //                     const Spacer(),
        //                     Container(
        //                       padding: const EdgeInsets.all(16),
        //                       decoration: const BoxDecoration(
        //                           shape: BoxShape.circle, 
        //                           // color: kPrimaryColor
        //                           ),
        //                       child: const Icon(Icons.arrow_forward, color: Colors.black,),
        //                     )
        //                   ],
        //                 ),
        //               )
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      //),
    

