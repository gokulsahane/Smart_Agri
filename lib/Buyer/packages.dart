import 'package:flutter/material.dart';
import 'package:smart_agri/Buyer/home.dart';

class packages extends StatelessWidget {
  const packages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(  
           title: const Text('Packages'),
          // centerTitle: true,
          backgroundColor:  const Color.fromARGB(255, 247, 82, 17),
           leading: IconButton(
    icon: const Icon(Icons.arrow_back, color: Colors.white),
    onPressed: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) => buyer()))
  ), ),
      body: SingleChildScrollView(
      child:Container(
         margin:  EdgeInsets.all(20),
         child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,  
            children:[
            
                Container(
                  child:Column(
             crossAxisAlignment: CrossAxisAlignment.start,  
            children:[
              Text("PACKAGE NAME: Diamond",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("FEATURES: You can access all pomegranate plots for domestic as well as Europe market purpose.",style: TextStyle(fontSize: 15,),),
               SizedBox(height: 5,),
               Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),     
                    SizedBox(height: 10,),   
                    Text("PACKAGE NAME: Golden",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("FEATURES: You can access all pomegranate plots for domestic as well as Europe market purpose.",style: TextStyle(fontSize: 15,),),
                SizedBox(height: 5,),
               Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                     SizedBox(height: 10,),   
                    Text("PACKAGE NAME: Premium",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("FEATURES: You can access all pomegranate plots for domestic as well as Europe market purpose.",style: TextStyle(fontSize: 15,),),
                SizedBox(height: 5,),
               Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                     SizedBox(height: 10,),   
                    Text("PACKAGE NAME: Special",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("FEATURES: You can access all pomegranate plots for domestic as well as Europe market purpose.",style: TextStyle(fontSize: 15,),),
               SizedBox(height: 5,),
               Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                     SizedBox(height: 10,),   
                    Text("PACKAGE NAME: Regular",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              SizedBox(height: 5,),
              Text("FEATURES: You can access all pomegranate plots for domestic as well as Europe market purpose.",style: TextStyle(fontSize: 15,),),
                SizedBox(height: 5,),
               Divider(
                      thickness: 0.5,
                      color: Colors.black,
                    ),
                    
  ])
                ),
              
            ])
      ),));
      }}