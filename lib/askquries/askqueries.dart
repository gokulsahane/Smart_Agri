import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:smart_agri/firebase_options.dart';
import 'package:smart_agri/homepage.dart';

void main()  {
//   WidgetsFlutterBinding.ensureInitialized();
//    Firebase.initializeApp(
//    options: DefaultFirebaseOptions.currentPlatform,
//  );

  // Initialize a new Firebase App instance
  // await Firebase.initializeApp();
  runApp( askquries());
}

class askquries extends StatelessWidget {
  // const askquries({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Past Queries',
       theme: ThemeData(primarySwatch: Colors.red),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
   final _formKey = GlobalKey<FormState>();
  TextEditingController plotnumber = TextEditingController();
  TextEditingController subject= TextEditingController();
  TextEditingController discription =TextEditingController();
  FirebaseStorage storage = FirebaseStorage.instance;
    final ImagePicker imgpicker = ImagePicker();
    List<XFile>? imagefiles;

  openImages() async {
try {
    var pickedfiles = await imgpicker.pickMultiImage();
    //you can use ImageCourse.camera for Camera capture
    if(pickedfiles != null){
        imagefiles = pickedfiles;
        setState(() {
        });
    }else{
        print("No image is selected.");
    }
}catch (e) {
    print("error while picking file.");
}
  }

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    final picker = ImagePicker();
    XFile? pickedfiles;
    try {
      pickedfiles = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      final String fileName = path.basename(pickedfiles!.path);
      File imageFile = File(pickedfiles.path);

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
               'Plot_Number': plotnumber.text,
              'Subject': subject.text,
              'Discription': discription.text,
              // 'uploaded_by': plotnumber.text,
              // 'description': 'Some description...Some description...Some description...Some description...Some description...'
            }));

        // Refresh the UI
        setState(() {

        });
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  // Future<void> _upload(String inputSource)
  //  async {
  //   // final picker = ImagePicker();
  //   // XFile? pickedfiles;
  //   // try {
  //   //   pickedfiles = await picker.pickImage(
  //   //       source: inputSource == 'camera'
  //   //           ? ImageSource.camera
  //   //           : ImageSource.gallery,
  //   //       maxWidth: 1920);
  //   pickedfiles = await imgpicker.pickMultiImage();

  //     // final String fileName = path.basename(pickedfiles);
  //     // File imageFile = File(pickedfiles);

  //     try {
  //       // Uploading the selected image with some custom meta data
  //       await storage.ref(fileName).putFile(
  //           imageFile,
  //           SettableMetadata(customMetadata: {
  //              'Plot_Number': plotnumber.text,
  //             'Subject': subject.text,
  //             'Discription': discription.text,
  //             // 'uploaded_by': plotnumber.text,
  //             // 'description': 'Some description...Some description...Some description...Some description...Some description...'
  //           }));

  //       // Refresh the UI
  //       setState(() {

  //       });
  //     } on FirebaseException catch (error) {
  //       if (kDebugMode) {
  //         print(error);
  //       }
  //     }
  //   } catch (err) {
  //     if (kDebugMode) {
  //       print(err);
  //     }
  //   }
  // }

  // Retriew the uploaded images
  // This function is called when the app launches for the first time or when an image is uploaded or deleted
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "Plot_Number": fileMeta.customMetadata?['Plot_Number'] ?? 'Nobody',
        "Discription":
            fileMeta.customMetadata?['Discription'] ?? 'No description'
      });
    });

    return files;
  }

  // Delete the selected image
  // This function is called when a trash icon is pressed
  Future<void> _delete(String ref) async {
    await storage.ref(ref).delete();
    // Rebuild the UI
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Color.fromARGB(255, 211, 81, 5),
        title: const Text('Past Queries'),
        leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => introduction()))
  ),
      ),
      body: 
      Padding(
        padding:  EdgeInsets.all(20),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     ElevatedButton.icon(
            //         onPressed: () => _upload('camera'),
            //         icon: const Icon(Icons.camera),
            //         label: const Text('camera')),
            //     ElevatedButton.icon(
            //         onPressed: () => _upload('gallery'),
            //         icon: const Icon(Icons.library_add),
            //         label: const Text('Gallery')),
            //   ],
            // ),
            Expanded(
              child: FutureBuilder(
                future: _loadImages(),
                builder: (context,
                    AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data?.length ?? 0,
                      itemBuilder: (context, index) {
                        final Map<String, dynamic> image =
                            snapshot.data![index];

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 1),
                          child: ListTile(
                            dense: false,
                            leading: Image.network(image['url']),
                            title: Text(image['Plot_Number']),
                            subtitle: Text(image['Discription']),
                            trailing: IconButton(
                              onPressed: () => _delete(image['path']),
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
     floatingActionButton: Stack(
       fit: StackFit.expand,
       children: [
        
         Positioned(
           bottom: 20,
           right: 30,
           child: FloatingActionButton(
             backgroundColor:  Color.fromARGB(255, 211, 81, 5),
            //  heroTag: 'next',
             onPressed: () {
              // SingleChildScrollView(
              //   child:
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
		borderRadius: BorderRadius.circular(30),
	),
                    content: Stack(
                      // overflow: Overflow.visible,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.red,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Form(
                            key: _formKey,
                            
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                   child: Align(
                                alignment: Alignment.center,
                             child: Text(
                            'New Query',
                            textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                            ),
                            ),
                               ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: plotnumber,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelText: "Plot No",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 211, 81, 5),
                                    ),
                                  ),
              filled: true,
              // fillColor: Colors.blueAccent,
              border: OutlineInputBorder(
                
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: subject,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelText: "Subject",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 211, 81, 5),
                                    ),
                                  ),
              filled: true,
              // fillColor: Colors.blueAccent,
              border: OutlineInputBorder(
                
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
                                  ),
                                ),
                                 Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: discription,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Colors.black,
                                    ),
                                  ),
                                  labelText: "Discription",
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 211, 81, 5),
                                    ),
                                  ),
              filled: true,
              // fillColor: Colors.blueAccent,
              border: OutlineInputBorder(
                
                // borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
                                  ),
                                ),
                                // SizedBox(height: 10,),
                  //                ElevatedButton.icon(
                  //                  style: ElevatedButton.styleFrom(
                  //          primary: Colors.white //elevated btton background color
                  //     ),
                  //                 icon: Icon(Icons.image,color: Colors.black,),
                                  
                  //   onPressed: (){
                  //      openImages();
                  //     // _upload('gallery');
                  //         // openImages();
                  //   }, 
                  //   label: Text("Upload Images",
                  //   style: TextStyle(color: Colors.black),
                  //   )
                  // ),
                  // SizedBox(height: 10,),
                   Divider(),
                    imagefiles != null?Wrap(
                     children: imagefiles!.map((imageone){
                          return Container(
                             child:Card( 
                                child: Container(
                                   height: 30, width:30,
                                   child: Image.file(File(imageone.path)),
                                ),
                             )
                          );
                     }).toList(),
                  ):Container(),
                  SizedBox(height: 10,),
                  // Divider(),

                                // Padding(
                                //   padding: const EdgeInsets.all(8.0),
                                  SizedBox(
                                    width: 230,
                                    height: 50,
                                  child: ElevatedButton.icon(
                                    icon: Icon(Icons.image,color: Colors.white,),
                                    //  style: ElevatedButton.styleFrom(
                                    // Color:  Color.fromARGB(255, 211, 81, 5),),
                                    onPressed: () {
                                       _upload('gallery');
                                       Navigator.of(context).pop();
                                    },
                              label: Text('Upload Image & Submit'),
                              style: ElevatedButton.styleFrom(shape: StadiumBorder(),
                              backgroundColor:Color.fromARGB(255, 211, 81, 5),), ),
                                    )
                                
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                );
             },
             child: const Icon(
               Icons.add,
               size: 20,
             ),
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(40),
             ),
           ),
         ),



      // Padding(
      //   padding:  EdgeInsets.all(20),
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceAround,
      //         children: [
      //           ElevatedButton.icon(
      //               onPressed: () => _upload('camera'),
      //               icon: const Icon(Icons.camera),
      //               label: const Text('camera')),
      //           ElevatedButton.icon(
      //               onPressed: () => _upload('gallery'),
      //               icon: const Icon(Icons.library_add),
      //               label: const Text('Gallery')),
      //         ],
      //       ),
      //       Expanded(
      //         child: FutureBuilder(
      //           future: _loadImages(),
      //           builder: (context,
      //               AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
      //             if (snapshot.connectionState == ConnectionState.done) {
      //               return ListView.builder(
      //                 itemCount: snapshot.data?.length ?? 0,
      //                 itemBuilder: (context, index) {
      //                   final Map<String, dynamic> image =
      //                       snapshot.data![index];

      //                   return Card(
      //                     margin: const EdgeInsets.symmetric(vertical: 1),
      //                     child: ListTile(
      //                       dense: false,
      //                       leading: Image.network(image['url']),
      //                       title: Text(image['uploaded_by']),
      //                       subtitle: Text(image['description']),
      //                       trailing: IconButton(
      //                         onPressed: () => _delete(image['path']),
      //                         icon: const Icon(
      //                           Icons.delete,
      //                           color: Colors.red,
      //                         ),
      //                       ),
      //                     ),
      //                   );
      //                 },
      //               );
      //             }

      //             return const Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    ]));
  }
}








// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// // import 'package:simple_speed_dial/simple_speed_dial.dart';

// void main() {
//   runApp(const Queries());
// }

// class Queries extends StatelessWidget {
//   const Queries({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // theme: ThemeData(
//       //   primarySwatch: Colors.blue,
//       //   visualDensity: VisualDensity.adaptivePlatformDensity,
//       // ),
//       home:  MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   // const MyHomePage({Key? key, required this.title}) : super(key: key);

//   // final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//    final _formKey = GlobalKey<FormState>();
//   // String _text = '';
//   final ImagePicker imgpicker = ImagePicker();
//   List<XFile>? imagefiles;

//   openImages() async {
// try {
//     var pickedfiles = await imgpicker.pickMultiImage();
//     //you can use ImageCourse.camera for Camera capture
//     if(pickedfiles != null){
//         imagefiles = pickedfiles;
//         setState(() {
//         });
//     }else{
//         print("No image is selected.");
//     }
// }catch (e) {
//     print("error while picking file.");
// }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:  const Color.fromARGB(255, 247, 82, 17),
//            leading: IconButton(
//     icon: const Icon(Icons.arrow_back, color: Colors.white),
//     onPressed: () => Navigator.of(context).pop(),
//   ),
//         title: Text("Past Queries"),
//       ),
//      body:  Center(),
// floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//      floatingActionButton: Stack(
//        fit: StackFit.expand,
//        children: [
        
//          Positioned(
//            bottom: 20,
//            right: 30,
//            child: FloatingActionButton(
//              backgroundColor:  Color.fromARGB(255, 211, 81, 5),
//             //  heroTag: 'next',
//              onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     shape: RoundedRectangleBorder(
// 		borderRadius: BorderRadius.circular(30),
// 	),
//                     content: Stack(
//                       // overflow: Overflow.visible,
//                       children: <Widget>[
//                         Positioned(
//                           right: -40.0,
//                           top: -40.0,
//                           child: InkResponse(
//                             onTap: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: CircleAvatar(
//                               child: Icon(Icons.close),
//                               backgroundColor: Colors.red,
//                             ),
//                           ),
//                         ),
//                         Form(
//                           key: _formKey,
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: <Widget>[
//                               Container(
//                                  child: Align(
//                               alignment: Alignment.center,
//                            child: Text(
//                           'New Query',
//                           textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold
//                           ),
//                           ),
//                              ),
//                               ),
//                               SizedBox(height: 10,),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: const BorderSide(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 labelText: "Plot No",
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromARGB(255, 211, 81, 5),
//                                   ),
//                                 ),
//               filled: true,
//               // fillColor: Colors.blueAccent,
//               border: OutlineInputBorder(
                
//                 // borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(50)
//               ),
//             ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: const BorderSide(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 labelText: "Subject",
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromARGB(255, 211, 81, 5),
//                                   ),
//                                 ),
//               filled: true,
//               // fillColor: Colors.blueAccent,
//               border: OutlineInputBorder(
                
//                 // borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(50)
//               ),
//             ),
//                                 ),
//                               ),
//                                Padding(
//                                 padding: EdgeInsets.all(8.0),
//                                 child: TextFormField(
//                                   decoration: InputDecoration(
//                                     enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: const BorderSide(
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                                 labelText: "Discription",
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(30),
//                                   borderSide: const BorderSide(
//                                     color: Color.fromARGB(255, 211, 81, 5),
//                                   ),
//                                 ),
//               filled: true,
//               // fillColor: Colors.blueAccent,
//               border: OutlineInputBorder(
                
//                 // borderSide: BorderSide.none,
//                 borderRadius: BorderRadius.circular(50)
//               ),
//             ),
//                                 ),
//                               ),
//                               SizedBox(height: 10,),
//                                ElevatedButton.icon(
//                                  style: ElevatedButton.styleFrom(
//                          primary: Colors.white //elevated btton background color
//                       ),
//                                 icon: Icon(Icons.image,color: Colors.black,),
                                
//                     onPressed: (){
//                         openImages();
//                     }, 
//                     label: Text("Upload Images",
//                     style: TextStyle(color: Colors.black),
//                     )
//                   ),
//                   // SizedBox(height: 10,),
//                    Divider(),
//                     imagefiles != null?Wrap(
//                      children: imagefiles!.map((imageone){
//                         return Container(
//                            child:Card( 
//                               child: Container(
//                                  height: 30, width:30,
//                                  child: Image.file(File(imageone.path)),
//                               ),
//                            )
//                         );
//                      }).toList(),
//                   ):Container(),
//                   SizedBox(height: 10,),
//                   // Divider(),

//                               // Padding(
//                               //   padding: const EdgeInsets.all(8.0),
//                                 SizedBox(
//                                   width: 100,
//                                   height: 50,
//                                 child: ElevatedButton(
//                                   //  style: ElevatedButton.styleFrom(
//                                   // Color:  Color.fromARGB(255, 211, 81, 5),),
//                                   onPressed: () {},
//                             child: Text('Submit'),
//                             style: ElevatedButton.styleFrom(shape: StadiumBorder(),
//                             backgroundColor:Color.fromARGB(255, 211, 81, 5),), ),
//                                   )
                              
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 });
//              },
//              child: const Icon(
//                Icons.add,
//                size: 20,
//              ),
//              shape: RoundedRectangleBorder(
//                borderRadius: BorderRadius.circular(40),
//              ),
//            ),
//          ),
// // Add more floating buttons if you want
//        ],
//      ),
//    );
//  }
// }

