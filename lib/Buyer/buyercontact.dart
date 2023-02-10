import 'package:flutter/material.dart';
import 'package:smart_agri/Buyer/home.dart';

class buyercontact extends StatelessWidget {
  const buyercontact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(  
           title: const Text('Contact Us'),
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
                height: 200,
                width: MediaQuery.of(context).size.width,
                 decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/contact.jpg"),
              fit: BoxFit.fill,
          )
        )
              ),
              SizedBox(height: 20,),
              Center(
                child: Container(
                  child:Column(
            // crossAxisAlignment: CrossAxisAlignment.center,  
            children:[
              Text("Smart Agri Advisory Services",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
               ImageIcon(
                size: 30,
    AssetImage('assets/phone.png',),
  ),
  SizedBox(height: 10,),
  Text("Crop Support",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  SizedBox(height: 10,),
  Text("9923169931",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  SizedBox(height: 20,),
               ImageIcon(
                size: 30,
    AssetImage('assets/phone.png',),
  ),
  SizedBox(height: 10,),
  Text("Technical Support",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  SizedBox(height: 10,),
  Text("9823405252",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  SizedBox(height: 20,),
               ImageIcon(
                size: 30,
    AssetImage('assets/location.png',),
  ),
  SizedBox(height: 10,),
  Text("Address",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
  SizedBox(height: 10,),
  
    Container(
      // margin: const EdgeInsets.all(20),
    child:Text("B-202, Pantnagar, Karad road,\n Pandharpur, Dist. Solapur",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ),
  ])
                ),
              )
            ])
      ),));
      }}