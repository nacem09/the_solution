import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:the_solution/Category/category.dart';
import 'package:the_solution/Home/compontes/InformationForApp.dart';
import 'package:the_solution/favourite.dart';

import 'animation/animationOFnavigator.dart';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 2 +
              MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/Drawer.png"), fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), bottomLeft: Radius.circular(50)),
          ),
          child: Center(
            child: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/drawerlogo.jpg"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            animation(
                                widget: category(),
                                direction: AxisDirection.up));
                      },
                      child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("images/drawercategory.jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width / 2 +
                                  MediaQuery.of(context).size.width / 4,
                              child: ListTile(
                                title: Text("الأقسام",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "cairo")),
                                trailing: Icon(
                                  Icons.category,
                                  color: Colors.blue,
                                ),
                              ))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            animation(
                                widget: Favourite(),
                                direction: AxisDirection.up));
                      },
                      child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("images/drawercategory.jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width / 2 +
                                  MediaQuery.of(context).size.width / 4,
                              child: ListTile(
                                title: Text("المفضلة",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "cairo")),
                                trailing: Icon(
                                  Icons.favorite,
                                  color: Colors.blue,
                                ),
                              ))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        AwesomeDialog(
                          context: context,
                          animType: AnimType.SCALE,
                          dialogType: DialogType.INFO_REVERSED,
                          body: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              "هذه الخاصية سوف تكون متاحة عن قريب ..تمتع بالتطبيق",
                              style: TextStyle(
                                color: Colors.blue,
                                fontFamily: "cairo",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )..show();
                      },
                      child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("images/drawercategory.jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width / 2 +
                                  MediaQuery.of(context).size.width / 4,
                              child: ListTile(
                                title: Text("طريقة الاضافه للتطبيق",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "cairo")),
                                trailing: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ),
                              ))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            animation(
                                widget: InformationForApp(),
                                direction: AxisDirection.up));
                      },
                      child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("images/drawercategory.jpg"),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 60,
                              width: MediaQuery.of(context).size.width / 2 +
                                  MediaQuery.of(context).size.width / 4,
                              child: ListTile(
                                title: Text("حول التطبيق",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontFamily: "cairo")),
                                trailing: Icon(
                                  Icons.info_rounded,
                                  color: Colors.blue,
                                ),
                              ))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
///////////////////////////////////////////////// END DRAWER  ///////////////////////////////////////////////////////////////
  }
}
