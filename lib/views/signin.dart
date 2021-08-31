import 'package:flutter/material.dart';
import 'package:noteit/services/auth.dart';

import 'package:firebase_core/firebase_core.dart';


class SignIn extends StatefulWidget {
  
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
 
 
  AuthService as=new AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
       leading:Image.asset("images/Background.png"),
       title: Text("NoteIt"),
       backgroundColor: Colors.deepPurple,
       ),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children:[
             Image.asset("images/note1.png",height:200,width:300),
             SizedBox(height:10,),
            Text("Have a beautiful day ahead",style: TextStyle(
                color: Colors.blue,
                fontSize: 17,
                fontWeight: FontWeight.bold),),
            SizedBox(height:16,),
            GestureDetector(
              onTap: (){
                as.SignInwithgoogle(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
                child: Text("Sign in with google",style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold
                ),),
                decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(30),
              
                
              ),),
            )
           ],
         ),
       ),
    );
  }
}