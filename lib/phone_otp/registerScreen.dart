import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smart_agri/Buyer/home.dart';
import 'package:smart_agri/homepage.dart';
import 'package:smart_agri/phone_otp/loggedInScreen.dart';
import 'package:smart_agri/phone_otp/loginScreen.dart';
import 'package:smart_agri/validator.dart';
// import 'package:phone_verification/loggedInScreen.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class RegisterScreen extends StatefulWidget {
  RegisterScreen({ Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formKeyOTP = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController nameController =  TextEditingController();
  final TextEditingController emailController =  TextEditingController();
  final TextEditingController cellnumberController = TextEditingController();
  final TextEditingController otpController =  TextEditingController();
   var  verificationID = "";
   final Set<String> registeredMobileNumbers = Set<String>();
    //  String radioButtonItem = 'ONE';
     String? id;
      String? selectedValue;
        var userName= '';
var userEmail = '';
var userType = '';
var PhoneNumber='';


  getOtp() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91${cellnumberController.text}",
        verificationCompleted: (phoneAuthCredential) async {
           print("This phone number is not registered33.");
        },
        verificationFailed: (verificationFailed) {
          setState(() {});
          print(verificationFailed);
        },
        codeSent: (verificationID, resendingToken) async {
          setState(() {
            this.verificationID = verificationID;
          });
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => LoggedInScreen()));
        },
        codeAutoRetrievalTimeout: (verificationID) async {});
    // Navigator.of(context)
    //.push(MaterialPageRoute(builder: (context) => OtpScreen()));
  }

  var isLoading = false;
  var isResend = false;
  var isRegister = true;
  var isOTPScreen = false;
  var verificationCode = '';

  //Form controllers
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    nameController.dispose();
    cellnumberController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    theme: ThemeData(
		            primaryColor: Color.fromARGB(255, 211, 81, 5),
                // primarySwatch: Color.fromARGB(255, 211, 81, 5),
	);
    return isOTPScreen ? returnOTPScreen() : registerScreen();
  }

  Widget registerScreen() {
    final node = FocusScope.of(context);
    return Scaffold(
        key: _scaffoldKey,
        // appBar: new AppBar(
        //   title: Text('Register new user'),
        // ),
        body: ListView(children: [
           Column(
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                                  Container(
                             height: 150.0,
                             width: 150.0,
                              decoration: const BoxDecoration(
                           image: DecorationImage(
                          image: AssetImage(
                               'assets/logo.png',),
                              fit: BoxFit.fitWidth,
                         ),
                         shape: BoxShape.rectangle,
                        ),
                          ),
                          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text('Selecte User Type',style: TextStyle(fontSize: 15),),
            Radio(
              //  value: 2,
               value: 'Farmer',
              groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                  // radioButtonItem = 'Farmer';
                    // id = 1;
                });
              },
            ),
            Text(
              'Farmer',
              style: new TextStyle(fontSize: 15.0),
            ),

            Radio(
                value: 'Buyer',
                // value: 2,
               groupValue: selectedValue,
              onChanged: (value) {
                setState(() {
                  selectedValue = value as String;
                  // radioButtonItem = 'Buyer';
                    //  id = 2;
                });
              },
            ),
            Text(
              'Buyer',
              style: new TextStyle(
                fontSize: 15.0,
              ),
            ),
          ],
        ),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50.0),
                        child: TextFormField(
                          validator: (value) =>
                        Validator.fullNameValidate(value ?? ""),
                          enabled: !isLoading,
                          controller: nameController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Name'),
                        ),
                      )),
                       Container(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50.0),
                        child: TextFormField(
                          validator: (value) => Validator.validateEmail(value ?? ""),
                          enabled: !isLoading,
                           keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => node.nextFocus(),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Email id'),
                        ),
                      )),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 50.0),
                        child: TextFormField(
                           validator: (value) =>
                        Validator.validatePhoneNumber(value ?? ""),
                          enabled: !isLoading,
                          keyboardType: TextInputType.phone,
                          controller: cellnumberController,
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => node.unfocus(),
                          decoration: InputDecoration(
                              hintText: 'Phone Number',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'Phone Number'),
                        ),
                      )),
                      Container(
                          margin: EdgeInsets.only(top: 40, bottom: 5),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 50.0),
                              child:  ElevatedButton(
                                 style: ButtonStyle(
                                     backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 247, 82, 17),),
                                        ),
                                onPressed: () {
                                  if (!isLoading) {
                                    if (_formKey.currentState!.validate()) {
                                      if (selectedValue == null) {
                                           Fluttertoast.showToast(msg: "Please Select User Type");
                                            } 
                                            else {
                                      // If the form is valid, we want to show a loading Snackbar
                                      setState(() {
                                        signUp();
                                        // getOtp();
                                        isRegister = false;
                                        isOTPScreen = true;
                                      });
                                    }
                                    }
                                  }
                                },
                                child:  Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15.0,
                                    horizontal: 15.0,
                                  ),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                       Expanded(
                                        child: Text(
                                          "Register Now",style: TextStyle(fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))),
                              Container(
                          margin: EdgeInsets.only(top: 15, bottom: 5),
                          alignment: AlignmentDirectional.center,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        "You have Account ?",
                                      )),
                                  InkWell(
                                    child: Text(
                                      'Login',style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    onTap: () => {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()))
                                    },
                                  ),
                                ],
                              )))
                    ],
                  ))
            ],
          )
        ]));
  }

  Widget returnOTPScreen() {
    return Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          
               backgroundColor: Color.fromARGB(255, 247, 82, 17),
                                        
          title: Text('OTP Screen'),
        ),
        body: ListView(children: [
          Form(
            key: _formKeyOTP,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Text(
                            !isLoading
                                ? "Enter OTP from SMS"
                                : "Sending OTP code SMS",
                            textAlign: TextAlign.center))),
                !isLoading
                    ? Container(
                        child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: TextFormField(
                          enabled: !isLoading,
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          initialValue: null,
                          autofocus: true,
                          decoration: InputDecoration(
                              labelText: 'OTP',
                              labelStyle: TextStyle(color: Colors.black)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter OTP';
                            }
                          },
                        ),
                      ))
                    : Container(),
                !isLoading
                    ? Container(
                        margin: EdgeInsets.only(top: 40, bottom: 5),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child:  ElevatedButton(
                              style: ButtonStyle(
                                     backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 247, 82, 17),),
                                        ),
                              onPressed: () async {
                                if (_formKeyOTP.currentState!.validate()) {
                                  // If the form is valid, we want to show a loading Snackbar
                                  // If the form is valid, we want to do firebase signup...
                                  setState(() {
                                    isResend = false;
                                    isLoading = true;
                                  });
                                  try {
                                    await _auth
                                        .signInWithCredential(
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    verificationCode,
                                                smsCode: otpController.text
                                                    .toString()))
                                        .then((user) async => {
                                              //sign in was success
                                              if (user != null)
                                                {
                                                  //store registration details in firestore database
                                                  await _firestore
                                                      .collection('users')
                                                      .doc(
                                                          _auth.currentUser?.uid)
                                                      .set(
                                                          {
                                                        'Name': nameController.text.trim(),
                                                        'PhoneNumber':cellnumberController.text.trim(),
                                                        'EmailID':emailController.text.trim(),
                                                        'UserType': selectedValue,
                                                      },
                                                          SetOptions(
                                                              merge:
                                                                  false)).then(
                                                          (value) => {
                                                                //then move to authorised area
                                                                setState(() {
                                                                  isLoading =
                                                                      false;
                                                                  isResend =
                                                                      false;
                                                                })
                                                              }),

                                                  setState(() {
                                                    isLoading = false;
                                                    isResend = false;
                                                  }),
                                                  Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext context) =>LoggedInScreen(),
                                                    ),
                                                    (route) => false,
                                                  )
                                                }
                                            })
                                        .catchError((error) => {
                                              setState(() {
                                                isLoading = false;
                                                isResend = true;
                                              }),
                                            });
                                    setState(() {
                                      isLoading = true;
                                    });
                                  } catch (e) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                  }
                                }
                              },
                              child: new Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15.0,
                                ),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Expanded(
                                      child: Text(
                                        "Submit",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                )
                              ].where((c) => c != null).toList(),
                            )
                          ]),
                isResend
                    ? Container(
                        margin: EdgeInsets.only(top: 40, bottom: 5),
                        child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child:  ElevatedButton(
                              style: ButtonStyle(
                                     backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 247, 82, 17),),
                                        ),
                              onPressed: () async {
                                setState(() {
                                  isResend = false;
                                  isLoading = true;
                                });
                                await signUp();
                              },
                              child:  Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 15.0,
                                  horizontal: 15.0,
                                ),
                                child:  Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                     Expanded(
                                      child: Text(
                                        "Resend Code",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )))
                    : Column()
              ],
            ),
          )
        ]));
  }


         


  Future signUp() async {
     setState(() {
      isLoading = true;
    });

    var phoneNumber = '+91 ' + cellnumberController.text.trim();

    //first we will check if a user with this cell number exists
    var isValidUser = false;
    var number = cellnumberController.text.trim();

    await _firestore
        .collection('users')
        .where('PhoneNumber', isEqualTo: number)
        .get()
        .then((result) {
      if (result.docs.length > 0) {
        isValidUser = true;
      }
    });

    if (isValidUser) {
       Fluttertoast.showToast(msg: "This Mobile Number Already Register!");
      print("This Number Already Register");
       Navigator.pushAndRemoveUntil( context, MaterialPageRoute(builder: (BuildContext context) => LoginScreen(),),
                      (route) => false,
                    );
    }

    else{
    setState(() {
      isLoading = true;
    });
    debugPrint('Gideon test 1');
    var phoneNumber = '+91 ' + cellnumberController.text.toString();
    debugPrint('Gideon test 2');

    var verifyPhoneNumber = _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        debugPrint('Gideon test 3');
        //auto code complete (not manually)
        _auth.signInWithCredential(phoneAuthCredential).then((user) async => {
               if (user!= null)
                {
                  //store registration details in firestore database
                   await _firestore
                      .collection('users')
                       .doc(_auth.currentUser!.uid)
                      .set(
                           { 
                        'UserType': selectedValue,
                        'Name': nameController.text.trim(),
                        'PhoneNumber': cellnumberController.text.trim(),
                         'EmailID':emailController.text.trim(),
                        // 'PhoneNumber': cellnumberController.text.trim()
                        // 'PhoneNumber': cellnumberController.text.trim()
                      }, 
                     
                      SetOptions(merge: false))
                      .then((value) => {
                            //then move to authorised area
                            setState(() {
                              isLoading = false;
                              isRegister = false;
                              isOTPScreen = false;

                              //navigate to is
                              if (selectedValue == 'Farmer') {
                              Navigator.pushAndRemoveUntil(context,MaterialPageRoute(
builder: (BuildContext context) =>
                                      introduction(),
                                ),
                                (route) => false,
                              );
                              }
                              else {
                  Navigator.push(
                    context, MaterialPageRoute(builder: (context) => buyer(),
                    ),
                  );
                }
                            })
                          })
                      .catchError((onError) => {
                            debugPrint(
                                'Error saving user to db.' + onError.toString())
                          })
                }
            });
        debugPrint('Gideon test 4');
      },
      verificationFailed: (FirebaseAuthException error) {
        debugPrint('Gideon test 5${error.message}');
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (verificationId, [forceResendingToken]) {
        debugPrint('Gideon test 6');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        debugPrint('Gideon test 7');
        setState(() {
          isLoading = false;
          verificationCode = verificationId;
        });
      },
      timeout: Duration(seconds: 60),
    );
    debugPrint('Gideon test 7');
    await verifyPhoneNumber;
    debugPrint('Gideon test 8');
  }
    }
}

