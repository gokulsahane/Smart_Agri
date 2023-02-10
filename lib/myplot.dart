import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class myplot extends StatefulWidget {
  @override
  State<myplot> createState() => myplotState();
}

class myplotState extends State<myplot> {
    final _key = GlobalKey<FormState>();
  TextEditingController plotNo = TextEditingController();
  TextEditingController plotArea= TextEditingController();
  TextEditingController plantSpacing =TextEditingController();
  TextEditingController plantPopulation =TextEditingController();
  // TextEditingController TypeofSoil =selectedValue();
  TextEditingController SoilPH =TextEditingController();
  TextEditingController SoilEC =TextEditingController();
  TextEditingController SourceofErigation =TextEditingController();
  TextEditingController TypeofErigation =TextEditingController();
  TextEditingController WaterPH =TextEditingController();
  TextEditingController WaterEC =TextEditingController();
  TextEditingController insect =TextEditingController();
  TextEditingController diseas =TextEditingController();
  TextEditingController other =TextEditingController();
  TextEditingController lastYearYield =TextEditingController();
  TextEditingController TargetedYield =TextEditingController();
  TextEditingController DateofPlantation = TextEditingController();
  TextEditingController DateofLeafShedding = TextEditingController();
  TextEditingController RestPeriod = TextEditingController();
  String? selectedValue;
  // late bool success;

   final FirebaseAuth _auth = FirebaseAuth.instance;
  User? users = FirebaseAuth.instance.currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;


     final List<String> items = [
    'Light',
    'Medium',
    'Heavy/Black',
    'Calcareous',
    
  ];
  void clearText() {
    plotNo.clear();
    plotArea.clear();
    plantSpacing.clear();
    plantPopulation.clear();
    SoilPH.clear();
    SoilEC.clear();
    SourceofErigation.clear();
    TypeofErigation.clear();
    WaterPH.clear();
    WaterEC.clear();
    insect.clear();
    diseas.clear();
    other.clear();
    lastYearYield.clear();
    TargetedYield.clear();
    DateofPlantation.clear();
    DateofLeafShedding.clear();
    RestPeriod.clear();
    // selectedValue.clear();
  }

  @override
  void initState() {
    DateofPlantation.text = "";
    DateofLeafShedding.text = "";
    RestPeriod.text = ""; //set the initial value of text field
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(  
           title:  Text('My Plot'),
          // centerTitle: true,
          backgroundColor:  const Color.fromARGB(255, 247, 82, 17),
           leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () => Navigator.of(context).pop(),
  ), ),
      body:
        SingleChildScrollView(
          child:Container(
             margin:  EdgeInsets.only(left: 20.0, right: 20.0),
             child:
            Form(
                         key: _key,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children:[
              SizedBox(height: 10,),
              
    SizedBox(height: 20,),
    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Plot No';
                                     }
                                   return null;
                                       },
                                 controller: plotNo,
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
                                labelText: "PLOT No",
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
                            
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Date of Plantation';
                                     }
                                   return null;
                                       },
                                 readOnly: true,  // when true user cannot edit text 
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                      setState(() {
                         DateofPlantation.text = formattedDate; //set foratted date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                                
                                cursorColor: Colors.black,
                                 controller: DateofPlantation,
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
                                labelText: "DATE OF PLANTATION",
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
                            
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Date of Leaf Shedding';
                                     }
                                   return null;
                                       },
                                
                                 readOnly: true,  // when true user cannot edit text 
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                      setState(() {
                         DateofLeafShedding.text = formattedDate; //set foratted date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
                                cursorColor: Colors.black,
                               controller: DateofLeafShedding,
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
                                labelText: "DATE OF LEAF SHEDDING",
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
                           
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Date of Rest Period';
                                     }
                                   return null;
                                       },
                               readOnly: true,  // when true user cannot edit text 
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                       initialDate: DateTime.now(), //get today's date
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                      print(formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                      setState(() {
                         RestPeriod.text = formattedDate; //set foratted date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },

                                cursorColor: Colors.black,
                               controller: RestPeriod,
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
                                labelText: "REST PERIOD",
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
                           
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Plot Area';
                                     }
                                   return null;
                                       },
                                 controller: plotArea,
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
                                labelText: "AREA(ACRES)",
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
                           
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Plant Spacing';
                                     }
                                   return null;
                                       },
                                 controller: plantSpacing,
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
                                labelText: "PLANT SPACING",
                                 labelStyle: TextStyle(
                                         color: Colors.black, //<-- SEE HERE
                                  ),
                                hintStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  
                                )),
                                ),),
                          ],
                        ),
                        SizedBox(height: 20,),
    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                           
                            Expanded(
                              child: TextFormField(
                                validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Plant Population';
                                     }
                                   return null;
                                       },
                                 controller: plantPopulation,
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
                                labelText: "PLANT POPULATION",
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            
                            Text("TYPE OF SOIL",style: TextStyle(fontWeight: FontWeight.w600),),
                            
                            
                            
                            DropdownButtonHideUnderline(
          child: DropdownButton2(
            isExpanded: true,
            hint: Row(
              children: const [
                // Icon(
                //   Icons.list,
                //   size: 16,
                //   color: Colors.black,
                // ),
                // SizedBox(
                //   width: 4,
                // ),
                Expanded(
                  child: Text(
                    'Select Soil Type',
                    style: TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value as String;
              });
            },
            icon: const Icon(
              Icons.arrow_drop_down,
            ),
            iconSize: 20,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.black,
            buttonHeight: 50,
            buttonWidth: 160,
            buttonPadding: const EdgeInsets.only(left: 14, right: 14),
            buttonDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                 color: Colors.white,
              ),
              color: Colors.white,
            ),
            buttonElevation: 2,
            itemHeight: 40,
            itemPadding: const EdgeInsets.only(left: 14, right: 14),
            dropdownMaxHeight: 200,
            dropdownWidth: 200,
            dropdownPadding: null,
            dropdownDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: Colors.white,
            ),
            dropdownElevation: 8,
            scrollbarRadius: const Radius.circular(40),
            scrollbarThickness: 6,
            scrollbarAlwaysShow: true,
            offset: const Offset(-20, 0),
          ),
        ),
            ]),
            SizedBox(height: 10,),
    
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children:   [
                           
                            Expanded(
                              child: TextFormField(
                                 controller: SoilPH,
                                cursorColor: Colors.black,
                               
                                 decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: "PH",
                                 labelStyle: TextStyle(
                                         color: Colors.black, //<-- SEE HERE
                                  ),
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  
                                )),),),
                                 SizedBox(width: 20,),
                                Expanded(
                              child: TextFormField(
                                 controller: SoilEC,
                                cursorColor: Colors.black,
                               
                                 decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                                labelText: "EC",
                                 labelStyle: TextStyle(
                                         color: Colors.black, //<-- SEE HERE
                                  ),
                                hintStyle: TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  
                                )),),),
                          ],
                        ),
                        SizedBox(height: 20,),
    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                           
                            Expanded(
                              child: TextFormField(
                                controller: SourceofErigation,
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
                                labelText: "SOURCE OF IRRIGATION",
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
                           
                            Expanded(
                              child: TextFormField(
                                controller: TypeofErigation,
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
                                labelText: "TYPE OF IRRIGATION",
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
                           mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                                Text("WATER",style: TextStyle(fontWeight: FontWeight.w600),),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                          children:  [
                           
                            Expanded(
                              child: TextFormField(
                                controller: WaterPH,
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
                                labelText: "PH",
                                 labelStyle: TextStyle(
                                         color: Colors.black, //<-- SEE HERE
                                  ),
                                hintStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  
                                )),),),
                                SizedBox(width: 20,),
                                Expanded(
                              child: TextFormField(
                                controller: WaterEC,
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
                                labelText: "EC",
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
                           mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                                Text("PROBLEM FACED LAST SEASON",style: TextStyle(fontWeight: FontWeight.w600),),
                          ],
                        ),
                        SizedBox(height: 10,),
    
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                           
                            Expanded(
                              child: TextFormField(
                                controller: insect,
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
                                labelText: "INSECT",
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
                           
                            Expanded(
                              child: TextFormField(
                                controller: diseas,
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
                                labelText: "DISEASES",
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
                           
                            Expanded(
                              child: TextFormField(
                                controller: other,
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
                                labelText: "OTHER",
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
                           
                            Expanded(
                              child: TextFormField(
                                controller: lastYearYield,
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
                                labelText: "LAST YEAR YIELED PER PLANT",
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
                           
                            Expanded(
                              child: TextFormField(
                                controller: TargetedYield,
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
                                labelText: "TARGETED YIELD PER PLANT",
                                 labelStyle: TextStyle(
                                         color: Colors.black, //<-- SEE HERE
                                  ),
                                hintStyle: const TextStyle(color: Colors.black),
                                border: OutlineInputBorder(
                                  
                                )),),),
                          ],
                        ),

                          // ]),
                        SizedBox(height: 30,),

                         Row(
                             mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
             onPressed: ()  {
              if (_key.currentState!.validate()) {
                   setState(() {
                    var PlotNo = plotNo.text;
                    var plot_Area= plotArea.text;
                    var plant_Spacing = plantSpacing.text;
                    var plant_Population = plantPopulation.text;
                    var Typeof_Soil = selectedValue;
                    var Soil_PH = SoilPH.text;
                    var Soil_EC = SoilEC.text;
                    var Sourceof_Erigation = SourceofErigation.text;
                    var Typeof_Erigation = TypeofErigation.text;
                    var Water_PH = WaterPH.text;
                     var Water_EC = WaterEC.text;
                      var Insect = insect.text;
                       var Diseas = diseas.text;
                        var Other = other.text;
                         var Targeted_Yield = TargetedYield.text;
                       var Dateof_Plantation = DateofPlantation.text;
                        var Dateof_LeafShedding = DateofLeafShedding.text;
                         var Rest_Period = RestPeriod.text;
                      plot( PlotNo, plot_Area, plant_Spacing, plant_Population, Typeof_Soil, Soil_PH, Soil_EC, Sourceof_Erigation,
                       Typeof_Erigation, Water_PH, Water_EC, Insect, Diseas, Other, Targeted_Yield, Dateof_Plantation, Dateof_LeafShedding, Rest_Period );
                  }
                   );
             }},
                       backgroundColor: const Color.fromARGB(255, 247, 82, 17),
           label:  Text("Save"),
          ),
          FloatingActionButton.extended(
             onPressed: ()  {
              // clearText()
             },
                       backgroundColor: const Color.fromARGB(255, 247, 82, 17),
           label:  Text("Cancel"),
          ),
          ]),
          SizedBox(height: 20,)
            
          ])),)));}

          Future<void> plot(PlotNo, plot_Area, plant_Spacing, plant_Population, Typeof_Soil, Soil_PH, Soil_EC, Sourceof_Erigation,
                       Typeof_Erigation, Water_PH, Water_EC, Insect, Diseas, Other, 
                       Targeted_Yield, Dateof_Plantation, Dateof_LeafShedding, Rest_Period ) async {
    print("Added");
    CollectionReference plot =
        FirebaseFirestore.instance.collection('Plot');
    // String uId = DateTime.now().microsecondsSinceEpoch.toString();
    // return Donation.add({'uId': uId, 'Name': Name});

     return await plot
        .doc(_auth.currentUser!.uid)
        .set({'PlotNo':PlotNo, 'plot_Area': plot_Area, 'plant_Spacing': plant_Spacing,'plant_Population':plant_Population,'Typeof_Soil':Typeof_Soil,'Soil_PH':Soil_PH,
         'Soil_EC':Soil_EC, 'Sourceof_Erigation':Sourceof_Erigation, 'Typeof_Erigation':Typeof_Erigation, 'Water_PH':Water_PH, 'Water_EC':Water_EC,'Insect':Insect, 'Diseas':Diseas, 'Other':Other,'Targeted_Yield':Targeted_Yield,
          'Dateof_Plantation':Dateof_Plantation, 'Dateof_LeafShedding':Dateof_LeafShedding,'Rest_Period':Rest_Period})
        .then((value) => {
          Fluttertoast.showToast(msg: "Plot Add Successfully"),
              // CherryToast.success(
              //    toastPosition: Position.bottom,
              //    autoDismiss: false,
              //   // displayIcon: success,
              //   displayCloseButton: true,
              //   title: Text('Plot Add Successfully'),
              //   borderRadius: 15,
              // ).show(context),
               clearText()
            },);
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
    

