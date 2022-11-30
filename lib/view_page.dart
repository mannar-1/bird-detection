import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';
class viewpage extends StatefulWidget {
  viewpage(this.doc,{Key? key}) : super(key: key);
  Map<String,dynamic> doc;

  @override
  State<viewpage> createState() => _viewpageState();
}

class _viewpageState extends State<viewpage> {
  final img='assets/prof.jpg';
  final img5='assets/view5.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.black87,
        titleSpacing: 25.0,
        title:Container(

          child: Row(

            children: const [
              SizedBox(width: 10,),
              Icon(Icons.person),
              SizedBox(width: 10,),
              Text("Student Profile")
            ],
          ),
        ),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w900,fontSize: 20.0),


      ),
      body:SingleChildScrollView(

        child:Padding(

          padding: const EdgeInsets.all(10.0),
          child:Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              const SizedBox(height: 30,),

              if(widget.doc['ipath']=="") Center(
                child: CircleAvatar(
                  radius: 120,
                  backgroundImage: AssetImage(img),
                ),
              ),
              if(widget.doc['ipath']!="")Center(
                  child: CircleAvatar(
                    radius: 120,
                    backgroundImage: FileImage(File(widget.doc['ipath'])),
                  )
              ),

              const SizedBox(height: 40,),
              Center(
                child:Container(
                  width: 308,
                  decoration: BoxDecoration(border: Border.all(width: 2.0),borderRadius: BorderRadius.circular(12.0)),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                      Text(widget.doc['name'],
                        style:GoogleFonts.notoSansHanunoo(color: Colors.black,fontSize:20),
                        overflow: TextOverflow.fade,
                      )


                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Center(
                child:Container(
                  width: 308,
                  decoration: BoxDecoration(border: Border.all(width: 2.0),borderRadius: BorderRadius.circular(12.0)),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.alternate_email_outlined)),
                      Text(widget.doc['email'],
                        style:GoogleFonts.notoSansHanunoo(color: Colors.black,fontSize:20),
                        overflow: TextOverflow.fade,),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child:Container(
                  width: 308,
                  decoration: BoxDecoration(border: Border.all(width: 2.0),borderRadius: BorderRadius.circular(12.0)),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(onPressed: (){}, icon: Icon(Icons.numbers_outlined)),
                      Text(widget.doc['roll_no'],
                        style:GoogleFonts.notoSansHanunoo(color: Colors.black,fontSize:20),
                        overflow: TextOverflow.fade,),


                    ],
                  ),
                ),
              ),
              SizedBox(height: 400,),

            ],
          ),
        ),
      ),


    );
  }
}
