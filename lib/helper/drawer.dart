//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noteit/services/auth.dart';


class mydrawer extends StatelessWidget {
  String url;
  String username;
  String email;
  mydrawer({required this.url,required this.username,required this.email});

  @override
  Widget build(BuildContext context) {
    AuthService as=new AuthService();
    //final imageurl="https://upload.wikimedia.org/wikipedia/en/thumb/4/41/Flag_of_India.svg/1200px-Flag_of_India.svg.png";
    return Drawer(
      elevation: 16.0,
      child:Container(
        color: Colors.deepPurple,
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child:UserAccountsDrawerHeader(
                
                margin:EdgeInsets.zero,
                accountName: Text(username),
                accountEmail:Text(email),
                currentAccountPicture:CircleAvatar(backgroundImage: NetworkImage(url),)
                ),
              ),
              ListTile(
                leading:Icon(
                  CupertinoIcons.home,
                  color:Colors.white,
                ),
                title:Text(
                  "Home",
                  textScaleFactor: 1.3,
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),
              ),
              ListTile(
                leading:Icon(
                  CupertinoIcons.bed_double_fill,
                  color:Colors.white,
                ),
                title:Text(
                  "Logout",
                  textScaleFactor: 1.5,
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),
                onTap:(){
                  as.signOut(context);
                }
              ),
               Divider(
              color: Colors.black
            ),
              ListTile(
                title:Text(
                  "Hey ${username}...Stay the beautiful person you are❤️",
                  textScaleFactor: 1.3,
                  style:TextStyle(
                    color:Colors.white,
                  ),
                ),  
              ),
            Divider(
              color: Colors.black
            ),
          ],
        ),
      ),
      
    );
  }
}