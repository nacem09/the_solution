import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:the_solution/favourite.dart';
import 'package:the_solution/Home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'the_solution',
      home: Home(),
      theme: ThemeData(
        primaryColor:
            Colors.blue[350], //هذي متاع اللون الاساسي الابار والدراور وهذين
        buttonColor:
            Colors.blue[400], //هذي طبعا تخلي كل بتم اديرها تجيك دغري زرقاء
        textTheme: TextTheme(
          //هذي طبعا عشان تختار نسق متاع نص معين وتسخدمة طول من هن
          body1: TextStyle(
              fontFamily: "Amiri",
              color: Colors.white,
              fontSize: 20), //لو كان استخدمت بدي واحد يجيك الخط طول اميري
          body2:
              TextStyle(fontFamily: "cairo"), //وهنا العكس طبعا نفس الي فوق ) ,
        ),
      ),
      routes: {"favourite": (context) => Favourite()},
    );
  }
}
