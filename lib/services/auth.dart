import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteit/services/database.dart';
import 'package:noteit/views/home.dart';
import 'package:noteit/views/signin.dart';
import 'package:firebase_core/firebase_core.dart';


class AuthService{
  // ignore: non_constant_identifier_names
  Future<User?> SignInwithgoogle(BuildContext context) async {
    
   

    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn _googleSignIn = new GoogleSignIn();

    final GoogleSignInAccount? _googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await _googleSignInAccount!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    final UserCredential result = await _firebaseAuth.signInWithCredential(credential);

    final User? userDetails = result.user;
    

    if (result == null) {
    }
     else {
        Map<String,dynamic> userMap = {
     "userName": userDetails!.displayName,
       "email": userDetails.email
      };
        DatabaseServices().uploadUserInfo(userDetails.uid, userMap);
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>myhome(
       userEmail: userDetails.email!,
       userName: userDetails.displayName!,
       userimage:userDetails.photoURL!,
      )
      ));

     }
     return userDetails;


  }
  
  Future<void> signOut(BuildContext context) async {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut().then((value){
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=>SignIn()));
    });
    ;
  }
}