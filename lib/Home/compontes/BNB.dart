import 'package:flutter/material.dart';

bottomNavigationBar(context) {
  return Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100), topRight: Radius.circular(100)),
    ),
    child: Container(
      child: Center(
          child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),
        child: Container(
          width: 35,
          height: 35,
          child: ClipRRect(
            child: Image.asset("images/drawerlogo.jpg", fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(500),
          ),
        ),
      )),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/appbar.jpg"), fit: BoxFit.cover),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: Colors.blue),
      width: MediaQuery.of(context).size.width,
      height: 50,
    ),
  );
}
