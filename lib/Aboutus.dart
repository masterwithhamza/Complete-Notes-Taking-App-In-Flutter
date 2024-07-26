import 'package:flutter/material.dart';
class about extends StatefulWidget {
  const about({super.key});

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: AppBar(title: Center(child: Text("About Us")),backgroundColor: Colors.cyan,),
      body: Center(
          child:ListView(
            scrollDirection: Axis.vertical,
            children:  <Widget>[
              SizedBox(height: 50,),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset("images/clogo.jpg",width: 80,height: 150,),
              ),
              SizedBox(height: 10,),
              Container(
                  margin: EdgeInsets.all(10),
                  child: Text("Our objective is to design and create the most elegant, functional,powerful,attractive and multi-stylish mobile application that re-innovate functionality. We comprehend that android is the fastest developing mobile platform and, because of which ,the interest for android applications' development is relentlessly expanding. This is a leading android application development incorporation that renders qualitative development solutions to enterprises across the globe. we have demonstrated mastery in application development that guarantees performance and productivity to your versatile operations bt harnessing our maximum intricate potential. We have a technically-sound team of android experts that have polished,best in class skills and certified expertise in mobile application development for the android platform. Our software engineers are dedicatedly focused on creating adaptable and powerful android application and also porting them to mobile platforms.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),))
            ],
          )
      ),

    );
  }
}
