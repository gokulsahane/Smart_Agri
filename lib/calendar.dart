import 'package:flutter/material.dart';
import 'package:add_2_calendar/add_2_calendar.dart';

void main() => runApp(calender());

class calender extends StatelessWidget {
@override
Widget build(BuildContext context) {
	return MaterialApp(
	home: HomePage(),
	theme: ThemeData(
		brightness: Brightness.dark,
	),
	);
}
}


class HomePage extends StatefulWidget {
@override
_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
        final _key = GlobalKey<FormState>();
       TextEditingController userEmailController =TextEditingController();
       TextEditingController eventNameController = TextEditingController();


// var _formKey = GlobalKey<FormState>();
// var isLoading = false;


     Event buildEvent({Recurrence? recurrence}) {
    return Event(
      
      title: eventNameController.text,
      description: 'example',
      // location: 'Flutter app',
      startDate: DateTime.now(),
      endDate: DateTime.now().add(Duration(minutes: 30)),
      allDay: false,
      iosParams: IOSParams(
        reminder: Duration(minutes: 40),
        url: "http://example.com",
      ),
      androidParams: AndroidParams(
        emailInvites: [userEmailController.text],
      ),
      recurrence: recurrence,
    );
  }

  void clearText() {
    userEmailController.clear();
    eventNameController.clear();
   
  }

   @override
  void dispose() {
    userEmailController.dispose();
    eventNameController.dispose();
    super.dispose();
     
  }

@override
Widget build(BuildContext context) {
	return MaterialApp(
      scaffoldMessengerKey: scaffoldMessengerKey,
      home:Scaffold(
        appBar: AppBar(
          title:  Text('Add Event to Calendar'),
           backgroundColor:  Color.fromARGB(255, 211, 81, 5),
           leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
  ), 
        ),
        body: 
        Container(
          margin: EdgeInsets.all(20),
          child:
        ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            
            Container(
              
              // margin: EdgeInsets.all(20),
              child:
            Form(
                         key: _key,
             
                child: Column(
                        children: [
                          Container(
                child:TextFormField(
                     validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Event Name';
                                     }
                                   return null;
                                       },
                                       keyboardType: TextInputType.name,
                  controller: eventNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                       borderRadius:  BorderRadius.all(
             Radius.circular(20),
                    ),),
                    labelText: 'Enter Event Name',
                  ),),),
                  SizedBox(height: 20,),
            
                Container(
                  child: TextFormField(
                     validator: (value) {
                                 Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
    RegExp regex = RegExp(pattern as String);
    if (!regex.hasMatch(value!)) {
      return ' Please enter a valid Email Address.';
    } else {
      return null;
    }
                                         },
                    controller: userEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                         borderRadius:  BorderRadius.all(
             Radius.circular(20),
                      ),),
                      labelText: 'Enter Your Email',
                    ),),
                )]),),),
                  SizedBox(height: 20,),
            ListTile(
              title: Text('Add Normal Event'),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                if (_key.currentState!.validate()) {
                Add2Calendar.addEvent2Cal(
                  buildEvent(),
                );}
                clearText();
              },
            ),
            Divider(),
            ListTile(
              title:  Text('Add Event weekly for 3 months'),
              subtitle:  Text("weekly for 3 months"),
              trailing: Icon(Icons.calendar_today),
              onTap: () {
                if (_key.currentState!.validate()) {
                Add2Calendar.addEvent2Cal(buildEvent(
                  recurrence: Recurrence(
                    frequency: Frequency.weekly,
                    endDate: DateTime.now().add(Duration(days:90 )),
                  ),
                ));}clearText();
              },
            ),
            Divider(),
            // ListTile(
            //   title:  Text('Add Event with Recurrence 2'),
            //   subtitle:  Text("every 2 months for 6 times (1 year)"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //     if (_key.currentState!.validate()) {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.monthly,
            //         interval: 2,
            //         ocurrences: 6,
            //       ),
            //     ));}clearText();
            //   },
            // ),
            // Divider(),
            // ListTile(
            //   title: const Text('Add Event with Recurrence 3'),
            //   subtitle:
            //       const Text("RRULE (android only) every year for 10 years"),
            //   trailing: Icon(Icons.calendar_today),
            //   onTap: () {
            //      if (_key.currentState!.validate()) {
            //     Add2Calendar.addEvent2Cal(buildEvent(
            //       recurrence: Recurrence(
            //         frequency: Frequency.yearly,
            //         rRule: 'FREQ=YEARLY;COUNT=10;WKST=SU',
            //       ),
            //     ));}clearText();
            //   },
            // ),
            // Divider(),
          ],
        ),
      ),)
    );
    
}
}
















// import 'package:flutter/material.dart';

// import 'package:add_2_calendar/add_2_calendar.dart';
// import 'package:smart_agri/contactus.dart';

// void main() => runApp(calender());

// class calender extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: HomePage(),
//       theme: ThemeData(
//         brightness: Brightness.dark,
//       ),
//     );
//   }
// }
//   // final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//   //     GlobalKey<ScaffoldMessengerState>();
//   //       final _key = GlobalKey<FormState>();
//   //      TextEditingController userEmailController =TextEditingController();
//   //      TextEditingController eventNameController = TextEditingController();

//   class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
  
// class _HomePageState extends State<HomePage> {
//   var _formKey = GlobalKey<FormState>();
//    final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
//       GlobalKey<ScaffoldMessengerState>();
//         final _key = GlobalKey<FormState>();
//        TextEditingController userEmailController =TextEditingController();
//        TextEditingController eventNameController = TextEditingController();


//   Event buildEvent({Recurrence? recurrence}) {
//     return Event(
//       title: eventNameController.text,
//       description: 'example',
//       location: 'Flutter app',
//       startDate: DateTime.now(),
//       endDate: DateTime.now().add(Duration(minutes: 30)),
//       allDay: true,
//       iosParams: IOSParams(
//         reminder: Duration(minutes: 40),
//         url: "http://example.com",
//       ),
//       androidParams: AndroidParams(
//         emailInvites: [userEmailController.text],
//       ),
//       recurrence: recurrence,
//     );
//   }
  

//   class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }
  
// class _HomePageState extends State<HomePage> {
//   var _formKey = GlobalKey<FormState>();

// //   class MyCustomForm extends StatefulWidget {  

// //   // late DatabaseReference dbRef;

// //   @override  
// //   MyCustomFormState createState() {  
// //     return MyCustomFormState();  
// //   }  
// // }

//     // final _formKey = GlobalKey<FormState>();  

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // debugShowCheckedModeBanner: false,
//       // scaffoldMessengerKey: scaffoldMessengerKey,
//       // home: Scaffold(
//         appBar: AppBar(
//           title:  Text('Add Event to Calendar'),
//            backgroundColor:  Color.fromARGB(255, 211, 81, 5),
//            leading: IconButton(
//     icon: const Icon(Icons.arrow_back, color: Colors.white),
//     onPressed: () => Navigator.of(context).pop(),
//   ), 
//         ),
//         body: 
//         Container(
//           margin: EdgeInsets.all(20),
//           child:
//         ListView(
//           // mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 20,),
            
//             Container(
              
//               // margin: EdgeInsets.all(20),
//               child:
//             Form(
//                          key: _key,
             
//                 child: Column(
//                         children: [
//                           Container(
//                 child:TextFormField(
//                    validator: (value) {
//                                  Pattern pattern = r'^[a-zA-Z0-9.][a-zA-Z0-9]+\.[a-zA-Z]+';
//     RegExp regex = RegExp(pattern as String);
//     if (!regex.hasMatch(value!)) {
//        return' Please Enter Event Name';
//     } else {
//       return null;
//     }
//                                        },
//                                        keyboardType: TextInputType.name,
//                   controller: eventNameController,
//                   decoration: InputDecoration(
//                     border: OutlineInputBorder(
//                        borderRadius:  BorderRadius.all(
//              Radius.circular(20),
//                     ),),
//                     labelText: 'Enter Event Name',
//                   ),),),
//                   SizedBox(height: 20,),
            
//                 Container(
//                   child: TextFormField(
//                      validator: (value) {
//                                  Pattern pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
//     RegExp regex = RegExp(pattern as String);
//     if (!regex.hasMatch(value!)) {
//       return ' Please enter a valid Email Address.';
//     } else {
//       return null;
//     }
//                                          },
//                     controller: userEmailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                          borderRadius:  BorderRadius.all(
//              Radius.circular(20),
//                       ),),
//                       labelText: 'Enter Your Email',
//                     ),),
//                 )]),),),
//                   SizedBox(height: 20,),
//             ListTile(
//               title: Text('Add Normal Event'),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () {
//                 if (_key.currentState!.validate()) {
//                 Add2Calendar.addEvent2Cal(
//                   buildEvent(),
//                 );}
//               },
//             ),
//             Divider(),
//             ListTile(
//               title:  Text('Add Event with Recurrence 1'),
//               subtitle:  Text("weekly for 3 months"),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () {
//                 if (_key.currentState!.validate()) {
//                 Add2Calendar.addEvent2Cal(buildEvent(
//                   recurrence: Recurrence(
//                     frequency: Frequency.weekly,
//                     endDate: DateTime.now().add(Duration(days: 60)),
//                   ),
//                 ));}
//               },
//             ),
//             Divider(),
//             ListTile(
//               title:  Text('Add Event with Recurrence 2'),
//               subtitle:  Text("every 2 months for 6 times (1 year)"),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () {
//                 if (_key.currentState!.validate()) {
//                 Add2Calendar.addEvent2Cal(buildEvent(
//                   recurrence: Recurrence(
//                     frequency: Frequency.monthly,
//                     interval: 2,
//                     ocurrences: 6,
//                   ),
//                 ));}
//               },
//             ),
//             Divider(),
//             ListTile(
//               title: const Text('Add Event with Recurrence 3'),
//               subtitle:
//                   const Text("RRULE (android only) every year for 10 years"),
//               trailing: Icon(Icons.calendar_today),
//               onTap: () {
//                 Add2Calendar.addEvent2Cal(buildEvent(
//                   recurrence: Recurrence(
//                     frequency: Frequency.yearly,
//                     rRule: 'FREQ=YEARLY;COUNT=10;WKST=SU',
//                   ),
//                 ));
//               },
//             ),
//             Divider(),
//           ],
//         ),
//       ),)
//     );
//   }
// }