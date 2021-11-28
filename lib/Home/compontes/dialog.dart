import 'package:flutter/material.dart';

showdialog(context)=>
     showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
      return AlertDialog(
      title: Center(child: Text(" الرجاء الانتظار قليلا")),
      content: Container(
      height: 40,
      child: Center(
      child: 
      CircularProgressIndicator(),
      ),
      ),
      titleTextStyle:
      TextStyle(fontFamily: "cairo", color: Colors.black),
      );
      });
              
  
  
