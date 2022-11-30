
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Mylogin extends StatefulWidget {
  const Mylogin({Key? key}) : super(key: key);

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  @override
  String email='',password='';
  bool fl=true;
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/login.png'),fit :BoxFit.cover

        )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body:Stack(
          children:[
            Container(
        padding: EdgeInsets.only(left:35,top:130),

              child : Text("Welcome",
              style: TextStyle(
             color: Colors.white, fontSize :33),
        )
              ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.5,right: 35
                ,left:35
                ),


               child: Column(
                 children:[
                   TextField(
                     onChanged: (value){
                       email=value;
                     },
      decoration: InputDecoration(
        fillColor: Colors.grey.shade100,
        filled:true,
        hintText: "email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
                   ),
                   SizedBox(
                     height: 30,
                   ),
                   TextField(
                     onChanged: (value){
                       password=value;
                     },
                     obscureText:true,
                     decoration: InputDecoration(

                         fillColor: Colors.grey.shade100,
                         filled:true,
                         hintText: "password",
                         border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10)
                         )
                     ),
                   ),
                   SizedBox(
                     height: 40,
                   ),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [Text('sign in',
                     style: TextStyle(
                       color: Color(0xff4c505b),
                       fontSize: 27,fontWeight: FontWeight.w700
                     ),
                     ),
                       CircleAvatar(
                         radius: 30,
                         backgroundColor: Color(0xff4c505b),
                         child: IconButton(
                           color:Colors.white,
                           onPressed: () async{
                             try {
                               UserCredential userCredential = await FirebaseAuth
                                   .instance
                                   .signInWithEmailAndPassword(
                                   email: email, password: password);

                             } on FirebaseAuthException catch (e) {
                               setState(() {
                                 fl=false;
                               });
                               if (e.code == 'user-not-found') {
                                 print('No user found for that email.');
                                 Navigator.pushNamed(context, 'register');
                               } else if (e.code == 'wrong-password') {
                                 Navigator.pushNamed(context, 'login');
                               }
                             }
                             if(fl) Navigator.pushNamed(context, 'predict');
                           },
                           icon:Icon(Icons.arrow_forward),

                         ),
                       )
                     ],

                   ),
                   SizedBox(
                     height: 40,
                   ),
                   Row(
                      children: [
                        TextButton(onPressed:(){
                          Navigator.pushNamed(context, 'register');

                        },
                            child:Text('Sign up',style:TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize:18,
                          color : Color(0xff4c505b),
                        )))
                      ],
                   )

                 ]
               ),

              ),
            )
      ],
            )

        )
      );
  }
}
