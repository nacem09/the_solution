import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_solution/Category/pageview.dart';
import 'package:the_solution/Home/compontes/animation/animationOFrefrech.dart';

class Favourite extends StatefulWidget {
  Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  var network;
  List<String> key =
      []; // هذي ليست عشان نخزن فيها المفاتيح الي مخزنات في الجهاز
  List<String> data =
      []; //هذي ليست عشان تاخذ البيانات من الذاكرة المؤقته وتبقا تعبي في المستر
  List<Map> master =
      []; //هذي ليست تعبي في كل معلومات الي في الذاكره المؤقت هعشان نستعملهن لوطا كيف مانبي
///////////////////////////////////////////////////////// GET DATA TO SharedPreferences ///////////////////////////////////
  getprefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("sucses");

    key = prefs.getKeys().toList();
    print(key);
    for (int i = 0; i < key.length; i++) {
      if (key[i] != "welcome") {
        data = prefs.getStringList(key[i])!;
        master.add({
          "id": data[0],
          "idmaster": data[1],
          "title": data[2],
          "url": data[3]
        });
        print(master);
        print(master.length);
        print("7897897987987987897978");
      }
    }
    setState(() {});
  }
///////////////////////////////////////////////////////// GET DATA TO SharedPreferences ///////////////////////////////////

//////////////////////////////////////////////////////// DELETE DATA FOR CACHE //////////////////////////////////////////
  delete(String key, int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    master.remove(i);
  }
//////////////////////////////////////////////////////// DELETE DATA FOR CACHE //////////////////////////////////////////

  @override
  void initState() {
    print("tatatatatatattatatatat");
    // TODO: implement initState
    super.initState();
    getprefs();
  }

  @override
  void dispose() {
    setState(() {});
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        network = event;
      });
    });
    return Scaffold(
///////////////////////////////////////////////////////  Appbar  /////////////////////////////////////////////////////////

        appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, refrech(widget: Favourite()));
                  },
                  icon: Icon(Icons.refresh))
            ],
            backgroundColor: Colors.blue[600],
            centerTitle: true,
            title: Text("المفضلة",
                style: TextStyle(
                    fontFamily: "cairo",
                    color: Colors.white,
                    shadows: [Shadow(color: Colors.black, blurRadius: 8)])),
            elevation: 10,
            shadowColor: Colors.blue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35)),
            )),
///////////////////////////////////////////////////////Appbar END /////////////////////////////////////////////////////////

////////////////////////////////////////////////// body ///////////////////////////////////////////////////////////////////////
        body:
/////////////////////////////////////////////////////// is Internrt disable ///////////////////////////////////////////
            network == ConnectivityResult.none
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.wifi_off, color: Colors.red),
                        Text("لقد فقدت الاتصال بالانترنت",
                            style: TextStyle(
                                fontFamily: "Amiri", color: Colors.black))
                      ],
                    ),
                  )
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////// is Internet active ////////////////////////////////////////
                : master.isEmpty
                    ? Center(
                        child: Text("لم تقم باضافة اي عنصر للمفضلة",
                            style: TextStyle(
                              fontFamily: "cairo",
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    : GridView.builder(
                        itemCount: master.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 10),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, i) {
                          return Dismissible(
                              onDismissed: (dismissibleDiraction) {
                                delete(master[i]["id"], i);
                                Navigator.pushReplacement(
                                    context, refrech(widget: Favourite()));
                              },
                              key: UniqueKey(),
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => Pageview(master[i]["id"],
                                      master[i]["url"], master[i]["idmaster"]));
                                },
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(23)),
                                    elevation: 6,
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 7.5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.blue),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            elevation: 6,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              height: 100,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        "${master[i]["url"]}",
                                                    placeholder:
                                                        (context, utl) {
                                                      return Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) {
                                                      return Container(
                                                          color: Colors.black12,
                                                          child: Icon(
                                                              Icons.error,
                                                              color:
                                                                  Colors.red));
                                                    },
                                                    fit: BoxFit.contain,
                                                  )),
                                            ),
                                          ),
                                          Text("${master[i]["title"]}",
                                              style: TextStyle(
                                                  fontFamily: "cairo",
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.black,
                                                        blurRadius: 8)
                                                  ]))
                                        ],
                                      ),
                                    )),
                              ));
                        }));
//////////////////////////////////////////////////  END body ///////////////////////////////////////////////////////////////////////
  }
}
