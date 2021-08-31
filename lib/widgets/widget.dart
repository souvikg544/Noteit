import 'package:flutter/material.dart';
class widgets{

Widget mainappbar()
{
  return AppBar(
    leading:Image.asset("images/preview.jpg"),
    title: Text("NoteIt"),
    backgroundColor: Colors.cyanAccent,
  );
}
}