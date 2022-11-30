import 'dart:io';
import 'package:birddetection/web_page.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';
import  'package:image/image.dart' as img;
import 'package:birddetection/weblinks.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'classifer.dart';
class Showpage extends StatefulWidget {
  const Showpage({Key? key}) : super(key: key);

  @override
  State<Showpage> createState() => _ShowpageState();
}

class _ShowpageState extends State<Showpage> {
  String path="";
  String srch="";
  String? mail="";
  String name="";
  File? _image;
  Category? category;
  late Classifier _classifier;
  @override
  void initState() {
    super.initState();
    _classifier = Classifier();
    setState(() {
      mail=FirebaseAuth.instance.currentUser?.email;
    });
  }
  final img1='assets/prof.jpg';
  TextEditingController search=TextEditingController();
  ScrollController bar=ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        shadowColor: Colors.black,
        backgroundColor: Colors.black87,
        title: const Text("Aves"),
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w900,fontSize: 20.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:Column(
            children: [
              path!=""?Container(
                height:300 ,
                width:MediaQuery.of(context).size.width ,
                decoration: BoxDecoration(image: DecorationImage(image: FileImage(File(path)))),
              ):Container(
                  height:300 ,
                  width:MediaQuery.of(context).size.width ,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/emp.png'))),
              ),
              SizedBox(height: 20,),
              FloatingActionButton.extended(label: Text("Predict"),onPressed: getImage()  ),
              SizedBox(height: 20,),
              FloatingActionButton.extended(label: Text("View more"),onPressed:(){
                Navigator.push(context,MaterialPageRoute(builder: (context) => wikiPedia(info.weblink[category!.label]!),));
              }),
              Text(
                category != null ? category!.label: '',



                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),

              SizedBox(
                height: 8,
              ),
              Text(
                category != null
                    ? 'Confidence: ${category!.score.toStringAsFixed(3)}'
                    : '',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20,),
              Text('History',style: TextStyle(fontSize: 33)),
              Container(
                height: 50,
                child:TextField(
                  controller: search,
                  onChanged: (val) => {
                    setState((){
                      srch=val;
                    })
                  },
                  cursorColor: Colors.black87,
                  decoration:InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical:10.0 ,horizontal:10.0 ),
                    hintText: "Search",


                    suffixIcon: Icon(Icons.search_sharp),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                  ),
                ),
              ),
              SizedBox(height: 30,),

              SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(stream: FirebaseFirestore.instance.collection(mail!).snapshots(),
                  builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(child: CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.hasData){
                      return  ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          var data=snapshot.data!.docs[index].data() as Map<String,dynamic>;
                          if(srch.isEmpty){
                            return studentCard(data);
                          }
                          if(data['name'].toString().toLowerCase().contains(srch.toLowerCase())){
                            return studentCard(data);
                          }
                          return ColoredBox(color: Colors.white);

                        },
                      );
                    }
                    return Text("No Details to View", style: GoogleFonts.nunito(fontSize: 17,color:Colors.white ),);
                  },
                ),
              )

            ],
          ),

        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text("Select Image"),
        onPressed: (){
          showModalBottomSheet(context: context, builder: (context)=>Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton.extended(
                  label: Text('Camera'),
                    onPressed: () async{
                  final img=await ImagePicker().pickImage(source: ImageSource.camera);
                  setState(() {
                      path=img!.path;
                      name=img.name;

                  });
                  Navigator.pop(context);

                }),
                SizedBox(width: 70,),
                FloatingActionButton.extended(
                    label: Text('Gallery'),
                    onPressed: () async{
                  final img=await ImagePicker().pickImage(source: ImageSource.gallery);
                  setState(() {
                    path=img!.path;
                    name=img.name;
                  });
                  Navigator.pop(context);
                })
              ],
            ),
          ));
        },
        icon: Icon(Icons.add_a_photo),
      ),
    );
  }

  Widget studentCard(Map<String,dynamic> doct) {

    return GestureDetector(
      child:Column(
          children:[
            Container(

              decoration: BoxDecoration(border: Border.all(width: 2.0),borderRadius: BorderRadius.circular(10.0)),
              child:
              ListTile(

                // decoration: BoxDecoration(
                //   color: Colors.black87,
                //
                //   borderRadius: BorderRadius.circular(8.0),
                // ) ,
                tileColor: Colors.white70,

                selected: true,
                title: Text(
                  doct['prediction'],
                  style:GoogleFonts.notoSansHanunoo(color: Colors.black,fontWeight:FontWeight.bold),
                  overflow: TextOverflow.fade,
                ),
                subtitle:Text(
                  doct['confidence'],
                  style:GoogleFonts.notoSansHanunoo(color: Colors.black,fontWeight:FontWeight.bold),
                  overflow: TextOverflow.fade,
                ),
                // decoration: UnderlineTabIndicator( insets: EdgeInsets.all(2.0)),
                leading:Container(
                  width: 90,
                  height: 90,
                  child:Row(
                    children: [
                      if(doct['image url']=="")CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage(img1),
                      ),
                      if(doct['image url']!="")CircleAvatar(
                        radius: 30,
                        backgroundImage:NetworkImage(doct['image url']),
                      ),


                    ],
                  ),
                ),
                trailing: IconButton(
                    icon:Icon(Icons.delete),
                    onPressed:(){
                      FirebaseFirestore.instance.collection(mail!).doc(doct['docid']).delete();
                    }

                ),

              ),
            ),
          ]
      ),
    );
  }
   getImage(){
    setState(() {
      _image = File(path);

      _predict();
    });
  }

  void _predict() async {
    img.Image imageInput = img.decodeImage(_image!.readAsBytesSync())!;
    var pred = _classifier.predict(imageInput);
    setState(() {
      category = pred;
    });
    try{
      await FirebaseStorage.instance.ref('$mail/$name').putFile(File(path));
    }on FirebaseException catch (e){print(e);}
    String dt=await FirebaseStorage.instance.ref('$mail/$name').getDownloadURL();
    String date=DateTime.now().toString();
    FirebaseFirestore.instance.collection(mail!).doc(date).set({
      "prediction":category!.label,
      "confidence":"${(category!.score*100).toStringAsFixed(2)}%",
      "image url":dt,
      "docid":date,
    }).catchError((error) => print("Failed to add new profile due to $error"));
  }


}

