
import 'package:birddetection/register.dart';
import 'package:birddetection/showpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'login.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'login',
    routes: {
      'login':(context)=>Mylogin(),
      'predict':(context)=>Showpage(),
      'register' : (context)=>MyRegister(),

  },
  ));


}



