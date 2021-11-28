import 'package:flutter/material.dart';

class InformationForApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Image.asset(
                  "images/IFA.jpg",
                  fit: BoxFit.fill,
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              elevation: 6,
                              color: Colors.blue[400],
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("معلومات حول التطبيق",
                                    style: TextStyle(
                                      fontFamily: "cairo",
                                      color: Colors.white,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black, blurRadius: 10)
                                      ],
                                    )),
                              ))),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////
                      SizedBox(
                        height: 10,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          title: Text("منشئ التطبيق : نسيم حامد عبدالله",
                              style: TextStyle(
                                  fontFamily: "cairo", color: Colors.black)),
                          trailing: Icon(Icons.person, color: Colors.blue),
                        ),
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      SizedBox(
                        height: 10,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          title: Text(
                              "المهنة : طالب بكلية الهندسة قسم هندسة حاسوب",
                              style: TextStyle(
                                  fontFamily: "cairo", color: Colors.black)),
                          trailing: Icon(Icons.engineering, color: Colors.blue),
                        ),
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      SizedBox(
                        height: 10,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          title: Text("اصدار التطبيق : الاصدار رقم 1",
                              style: TextStyle(
                                  fontFamily: "cairo", color: Colors.black)),
                          trailing: Icon(Icons.format_list_numbered,
                              color: Colors.blue),
                        ),
                      ),

                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      SizedBox(
                        height: 10,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          title: Text(
                              "هدف التطبيق : سهولة التواصل بين افراد المجتمع من الناحية الخدمية ",
                              style: TextStyle(
                                  fontFamily: "cairo", color: Colors.black)),
                          trailing:
                              Icon(Icons.social_distance, color: Colors.blue),
                        ),
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      SizedBox(
                        height: 10,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        child: ListTile(
                          title: Text(
                              "التطبيق لزال قيد التجريب ونود الايضاح ايضا ان هذا التطبيق غير تابع لأي جهه حكومية وقد تمت برمجته وجمع معلوماته بمجهودات ذاتيه",
                              style: TextStyle(
                                  fontFamily: "cairo", color: Colors.black)),
                          trailing:
                              Icon(Icons.lightbulb_sharp, color: Colors.blue),
                        ),
                      ),

                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      SizedBox(
                        height: 30,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////

                      Center(
                          child: Card(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(500)),
                              child: Container(
                                  width: 85,
                                  height: 85,
                                  child: ClipRRect(
                                    child: Image.asset("images/drawerlogo.jpg",
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(500),
                                  )))),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
