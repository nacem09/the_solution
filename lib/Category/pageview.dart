import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_solution/Home/compontes/dialog.dart';

class Pageview extends StatefulWidget {
  late String urlimage;
  late var id;
  late var idMaster;
  Pageview(this.id, this.urlimage, this.idMaster);

  @override
  _PageviewState createState() => _PageviewState();
}

class _PageviewState extends State<Pageview> {
  GlobalKey<FormState> report = new GlobalKey<FormState>();
  bool islike = false;
  List<String> faviourt = [];
  List menu = [];
  late String rep;

////////////////////////////////////////////////////// save favourite ////////////////////////////////////////////////////
  saveprefs() async {
    //طبعا الفنكشن هذي هيا الي تخزن
    SharedPreferences prefs = await SharedPreferences
        .getInstance(); //السطر هذا للبريفي س عشان انستان من شار وجو هذ

    prefs.setStringList(widget.id,
        faviourt); //طبعا القيت ليست هذي لازم كان تبي اتمرر ليست لازم متخليهش داينك خليها تقبل سترينق

    print("sucses");
  }
///////////////////////////////////////////////////////// END save favourite ////////////////////////////////////////////////////

////////////////////////////////////////////////////// delete favourite ////////////////////////////////////////////////////
  deleteprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.id)) {
      prefs.remove(widget.id); //امر الحذف

      print("sucses99");
    }
  }
////////////////////////////////////////////////////// END delete favourite ////////////////////////////////////////////////////

//////////////////////////////////////////////////////Information like active or inactive ////////////////////////////////////////////////////

  infoLike() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(widget.id)) {
      islike = true;
    }
  }
/////////////////////////////////////////////////////// END Information like  //////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////// send report /////////////////////////////////////////
  sendReport() {
    if (report.currentState!.validate() == false) {
      AwesomeDialog(
        context: context,
        autoHide: Duration(seconds: 2),
        body: Text("حدث خطأ",
            style: TextStyle(fontFamily: "cairo", color: Colors.black)),
      )..show();
    }
    if (report.currentState!.validate()) {
      report.currentState!.save();
      showdialog(context);
      FirebaseFirestore.instance.collection('report').add({
        'id': widget.id,
        'idMaster': widget.idMaster,
        'urlImage': widget.urlimage,
        'report': rep
      }).then((value) {
        Navigator.of(context).pop();
      }).catchError((e) {
        AwesomeDialog(
          context: context,
          autoHide: Duration(seconds: 2),
          desc: 'حدث خطأ',
        )..show();
        Navigator.of(context).pop();
      });
    }
  }

///////////////////////////////////////////////////// end send report /////////////////////////////////////////
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    infoLike();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
//////////////////////////////////////////// bottomNavigationBar //////////////////////////////
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AwesomeDialog(
                      context: context,
                      btnOkColor: Colors.blue,
                      btnCancelColor: Colors.red,
                      btnOkText: 'موافق',
                      btnCancelText: 'الغاء',
                      btnOkOnPress: () {
                        sendReport();
                      },
                      btnCancelOnPress: () {},
                      body: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Form(
                          key: report,
                          child: TextFormField(
                            onSaved: (val) {
                              rep = val.toString();
                            },
                            validator: (val) {
                              if (val!.length > 1000)
                                return 'لا يمكن ان يكون البلاغ اكثر من 1000 حرف';
                              else if (val.length < 2)
                                return ' لا يمكن ان يكون البلاغ اقل من حرفين';
                              else
                                null;
                            },
                            maxLines: 200,
                            minLines: 1,
                            decoration: InputDecoration(
                                labelText: 'البلاغ عن مشاكل أو مخالفات',
                                labelStyle: TextStyle(
                                    color: Colors.black, fontFamily: 'cairo'),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.blue,
                                ))),
                          ),
                        ),
                      ))
                    ..show();
                },
                child: Icon(Icons.report, color: Colors.black)),

//////////////////////////////////////////// bottomNavigationBar //////////////////////////////

            body: SingleChildScrollView(
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Category")
                      .doc(widget.idMaster)
                      .collection("children")
                      .doc(widget.id)
                      .snapshots(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Erorr"); //كان في خطا يقولك في خطا
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data["key"] == 3) {
                        menu.addAll(snapshot.data["menu"]);
                      }

                      return Stack(children: [
//////////////////////////////////////////// Desighn page //////////////////////////////////////////////////////////////
                        Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Card(
                                    elevation: 10,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(500)),
                                    child: Container(
                                      width: 35,
                                      height: 35,
                                      child: ClipRRect(
                                        child: Image.asset(
                                            "images/drawerlogo.jpg",
                                            fit: BoxFit.cover),
                                        borderRadius:
                                            BorderRadius.circular(500),
                                      ),
                                    ),
                                  ),
                                  Text("${widget.idMaster}",
                                      style: TextStyle(
                                          fontFamily: "cairo",
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                              color: Colors.black,
                                              blurRadius: 8,
                                            )
                                          ])),
                                  LikeButton(
                                    isLiked: islike,
                                    likeBuilder: (isLiked) {
                                      if (isLiked) {
                                        faviourt.add(widget.id);
                                        faviourt.add(widget.idMaster);
                                        faviourt.add(snapshot.data["title"]);
                                        faviourt.add(snapshot.data["url"]);
                                        saveprefs();
                                      } else {
                                        deleteprefs();
                                      }
                                      final color =
                                          isLiked ? Colors.white : Colors.grey;

                                      return Icon(Icons.favorite, color: color);
                                    },
                                  ),
                                ]),
                            height: 200,
                            color: Colors.blue),
                        Container(
                          height: MediaQuery.of(context).size.height - 150,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(35),
                                  topRight: Radius.circular(35))),
                          margin: EdgeInsets.only(top: 150),
                        ),

                        ////////////////////////////////////////////  END Desighn page //////////////////////////////////////////////////////////////

                        //////////////////////////////////////////// Widget //////////////////////////////////////////////////////////////

                        Padding(
                          padding: const EdgeInsets.only(top: 155),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //////////////////////////////////////////// image //////////////////////////////////////////////////////////////

                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return Center(
                                          child: Container(
                                              color: Colors.white,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: MediaQuery.of(context)
                                                  .size
                                                  .height,
                                              child: PhotoView(
                                                minScale: PhotoViewComputedScale
                                                    .contained,
                                                maxScale: PhotoViewComputedScale
                                                        .covered *
                                                    1.8,
                                                backgroundDecoration:
                                                    BoxDecoration(
                                                  color: Colors.white,
                                                ),
                                                imageProvider: NetworkImage(
                                                  "${widget.urlimage}",
                                                ),
                                                loadingBuilder: (BuildContext
                                                        context,
                                                    ImageChunkEvent? event) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                                errorBuilder:
                                                    (context, url, error) {
                                                  return Container(
                                                      color: Colors.black12,
                                                      child: Icon(Icons.error,
                                                          color: Colors.red));
                                                },
                                              )),
                                        );
                                      });
                                },
                                child: Card(
                                  shadowColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25))),
                                  elevation: 8,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(25),
                                        child: CachedNetworkImage(
                                          imageUrl: "${widget.urlimage}",
                                          placeholder: (context, utl) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorWidget: (context, url, error) {
                                            return Container(
                                                color: Colors.black12,
                                                child: Icon(Icons.error,
                                                    color: Colors.red));
                                          },
                                          fit: BoxFit.contain,
                                        )),
                                  ),
                                ),
                              ),
                              //////////////////////////////////////////// End image //////////////////////////////////////////////////////////////

                              ////////////////////////////////////////////////////  Title /////////////////////////////////////////////////////////

                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text("${snapshot.data['title']}",
                                        style: TextStyle(
                                            fontFamily: "cairo",
                                            color: Colors.black)),
                                  ),
                                ),
                              ),

                              //////////////////////////////////////////////////// end  Title ///////////////////////////////////////////////////////////

                              ////////////////////////////////////////////////////  location /////////////////////////////////////////////////////////

                              snapshot.data["key"] == 2 ||
                                      snapshot.data["key"] == 3
                                  ? Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: Colors.blue),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                              "${snapshot.data['location']}",
                                              style: TextStyle(
                                                  fontFamily: "cairo",
                                                  color: Colors.black)),
                                        ),
                                      ),
                                    )
                                  : Container(),
//////////////////////////////////////////////////// end  location ///////////////////////////////////////////////////////////
                              snapshot.data["key"] == 3
                                  ? SizedBox(
                                      height: 20,
                                    )
                                  : Container(),
//////////////////////////////////////////////////// menu ///////////////////////////////////////////////////////////////////
                              snapshot.data["key"] == 3
                                  ? Center(
                                      child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              side: BorderSide(
                                                  color: Colors.blue)),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.blue),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text("قائمة المنتجات",
                                                    style: TextStyle(
                                                        fontFamily: "cairo",
                                                        color: Colors.black)),
                                              ))),
                                    )
                                  : Container(),

                              snapshot.data["key"] == 3
                                  ? Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          border:
                                              Border.all(color: Colors.blue),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Center(
                                                    child: Container(
                                                        color: Colors.white,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .height,
                                                        child: PageView.builder(
                                                          itemCount:
                                                              menu.length,
                                                          itemBuilder:
                                                              (contxt, i) {
                                                            return PhotoView(
                                                              minScale:
                                                                  PhotoViewComputedScale
                                                                      .contained,
                                                              maxScale:
                                                                  PhotoViewComputedScale
                                                                          .covered *
                                                                      1.8,
                                                              backgroundDecoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              imageProvider:
                                                                  NetworkImage(
                                                                menu[i],
                                                              ),
                                                              loadingBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      ImageChunkEvent?
                                                                          event) {
                                                                return Center(
                                                                  child:
                                                                      CircularProgressIndicator(),
                                                                );
                                                              },
                                                              errorBuilder:
                                                                  (context, url,
                                                                      error) {
                                                                return Container(
                                                                    color: Colors
                                                                        .black12,
                                                                    child: Icon(
                                                                        Icons
                                                                            .error,
                                                                        color: Colors
                                                                            .red));
                                                              },
                                                            );
                                                          },
                                                        )),
                                                  );
                                                });
                                          },
                                          child: CarouselSlider(
                                            options: CarouselOptions(
                                              aspectRatio: 2,
                                              height: 180.0,
                                              autoPlay: true,
                                              enlargeCenterPage: true,
                                              autoPlayAnimationDuration:
                                                  const Duration(
                                                      milliseconds: 800),
                                              autoPlayCurve:
                                                  Curves.linearToEaseOut,
                                              scrollDirection: Axis.horizontal,
                                            ),
                                            items: menu.map((i) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return Card(
                                                    elevation: 5,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        child:
                                                            CachedNetworkImage(
                                                          imageUrl: i,
                                                          placeholder:
                                                              (context, utl) {
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(),
                                                            );
                                                          },
                                                          errorWidget: (context,
                                                              url, error) {
                                                            return Container(
                                                                color: Colors
                                                                    .black12,
                                                                child: Icon(
                                                                    Icons.error,
                                                                    color: Colors
                                                                        .red));
                                                          },
                                                        )),
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(),

                              //////////////////////////////////////////////////// end menu ///////////////////////////////////////////////////////////////////

                              snapshot.data["key"] == 3
                                  ? SizedBox(
                                      height: 20,
                                    )
                                  : Container(),

////////////////////////////////////////////   الهاتف    //////////////////////////////////////////////////////////////

                              Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.blue),
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                        "رقم الهاتف : ${snapshot.data["phone"]}",
                                        style: TextStyle(
                                            fontFamily: "cairo",
                                            color: Colors.black)),
                                  ),
                                ),
                              ),
////////////////////////////////////////////   End الهاتف    //////////////////////////////////////////////////////////////

                              ////////////////////////////////////////////////////    الاتصال /////////////////////////////////////////////////////////////

                              Center(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 20),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Column(
                                    children: [
                                      Text("الاتصال",
                                          style: TextStyle(
                                              fontFamily: "cairo",
                                              color: Colors.black,
                                              fontSize: 15)),
                                      Icon(Icons.call)
                                    ],
                                  ),
                                  onPressed: () async {
                                    String number = snapshot.data["phone"];
                                    await FlutterPhoneDirectCaller.directCall(
                                        number);
                                  },
                                ),
                              ))

                              ////////////////////////////////////////////////////     END الاتصال /////////////////////////////////////////////////////////////
                            ],
                          ),
                        ),
                      ]);
                    }

                    return Center(
                      child: CircularProgressIndicator(),
                    ); //الشرطين متحققنش ايدرين هذي
                  }),
            )));
  }
}
