import 'package:flutter/material.dart';
//import 'package:noteit/views/home.dart';
import 'package:noteit/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
   runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        //scaffoldBackgroundColor: Color(0xff8C93A8),
      ),
      home:SignIn()
      //myhome(userName: "Rick", userEmail:"bjab",userimage: "",)
    );
  }
}



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
       
        title: Text("Hey"),
      ),
     
       );
  }

