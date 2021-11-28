import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:the_solution/Category/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:the_solution/Home/compontes/BNB.dart';
import 'package:the_solution/Home/compontes/WelcomeMassage.dart';
import 'package:the_solution/Home/compontes/appbar.dart';
import 'package:the_solution/Home/compontes/animation/animationOFnavigator.dart';
import 'package:the_solution/Home/compontes/drawer.dart';

List carouselOne = [];
List carouseltwo = [];
var network;
var checkcarouselone = false;
var checkcarouseltwo = false;
bool w = false;

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
////////////////////////////////////////////////////////////// Function Get image carousel one ///////////////////////////////////////////////////////////////////
  getdatacarouselOne() async {
    //الفنكشن هذي هيا الي تجيب البيانات ولازم تبقا اسبنك عشان في وقت
    ///////////////////// الي فوق الطرية الاولى/////////////////////////////
    CollectionReference user = FirebaseFirestore.instance.collection(
        "carouselOne"); //هذي تخلي المغير يوزر ياخذ المعلومات يقدر يوصللهن يعني زي المصادقه
    QuerySnapshot query =
        await user.get(); //هكي الكويري تحصل عالمعلومات الي عنده
    List<QueryDocumentSnapshot<Object?>> listdocs = query
        .docs; //طبعا هذي خلتنا ناخذو الدوكمن بتحديد وحطينهن في ليست في اللليست دوكس

    listdocs.forEach((element) {
      carouselOne.add(element['url']);
      print(
          "=================================================================");
    });
    setState(() {
      checkcarouselone = true;
    });
  }
////////////////////////////////////////////////////////////// END Function Get image carousel one ///////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////// Function Get image carousel two ///////////////////////////////////////////////////////////////////
  getdatacarouseltwo() async {
    //الفنكشن هذي هيا الي تجيب البيانات ولازم تبقا اسبنك عشان في وقت
    ///////////////////// الي فوق الطرية الاولى/////////////////////////////
    CollectionReference user = FirebaseFirestore.instance.collection(
        "carouseltwo"); //هذي تخلي المغير يوزر ياخذ المعلومات يقدر يوصللهن يعني زي المصادقه
    QuerySnapshot query =
        await user.get(); //هكي الكويري تحصل عالمعلومات الي عنده
    List<QueryDocumentSnapshot<Object?>> listdocs = query
        .docs; //طبعا هذي خلتنا ناخذو الدوكمن بتحديد وحطينهن في ليست في اللليست دوكس

    listdocs.forEach((element) {
      carouseltwo.add(element['url']);
      print(
          "=================================================================");
    });
    setState(() {
      checkcarouseltwo = true;
    });
  }

  ////////////////////////////////////////////////////////////// END Function Get image carousel two ///////////////////////////////////////////////////////////////////
  @override
  void initState() {
    getnetwork(){
    Connectivity().checkConnectivity().then((value) {network = value;});
    }
    massage(context);
if(carouseltwo.isEmpty && carouselOne.isEmpty) {
      getdatacarouselOne();
      getdatacarouseltwo();
    }
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((event) {
      setState(() {
        network = event;
      });
    });

    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(

///////////////////////////////////////////////// DRAWER  ////////////////////////////////////////////////////////////////
            drawer: drawer(),
/////////////////////////////////////////////////END  DRAWER  ////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////bottom navigator bar  /////////////////////////////////////////////////////////
            bottomNavigationBar: bottomNavigationBar(context),
///////////////////////////////////////////////////////bottom navigator bar END /////////////////////////////////////////////////////////

///////////////////////////////////////////////////////  Appbar  /////////////////////////////////////////////////////////

            appBar: appbar(context),
///////////////////////////////////////////////////////Appbar END /////////////////////////////////////////////////////////

            body: network == ConnectivityResult.none
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
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),

////////////////////////////////////// CARSOUL ONE///////////////////////////////////////////////////////
                        GetBuilder<Active>(
                            init: Active(),
                            builder: (active) {
                              if (checkcarouselone == false) {
                                return Container(
                                    height: 200,
                                    width: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ));
                              }
                              return CarouselSlider(
                                options: CarouselOptions(
                                  onPageChanged: (i, chang) {
                                    active.changeactive(i);
                                  },
                                  aspectRatio: 2.2,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.linearToEaseOut,
                                  scrollDirection: Axis.horizontal,
                                ),
                                items: carouselOne.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return Center(
                                                  child: Card(
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
                                                  ),
                                                );
                                              });
                                        },
                                        child: Card(
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child: CachedNetworkImage(
                                                imageUrl: i,
                                                placeholder: (context, utl) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) {
                                                  return Container(
                                                      color: Colors.black12,
                                                      child: Icon(Icons.error,
                                                          color: Colors.red));
                                                },
                                              )),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            }),
////////////////////////////////////// END_CARSOUL ONE///////////////////////////////////////////////////////
                        SizedBox(
                          height: 10,
                        ),
//////////////////////////////////////// AnimatedSmoothIndicator OF CAROUSEL ONE/////////////////////////////////
                        GetBuilder<Active>(
                            init: Active(),
                            builder: (active) {
                              return AnimatedSmoothIndicator(
                                activeIndex: active.activeIndex,
                                count: checkcarouselone == false
                                    ? 3
                                    : carouselOne.length,
                                effect: WormEffect(
                                    dotColor: Colors.grey,
                                    activeDotColor: Colors.blue),
                              );
                            }),

//////////////////////////////////////// END AnimatedSmoothIndicator /////////////////////////////////

                        SizedBox(
                          height: 20,
                        ),
///////////////////////////////////////////// Route to category page ////////////////////////////////Gradle
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                animation(
                                    widget: category(),
                                    direction: AxisDirection.right));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 4, left: 4),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset("images/home2.jpg"),
                              ),
                            ),
                          ),
                        ),
///////////////////////////////////////////// END Route to category page ////////////////////////////////

                        SizedBox(
                          height: 10,
                        ),
/////////////////////////////////////////// Carsoul 2 ///////////////////////////////////////////////////
                        GetBuilder<Active>(
                            init: Active(),
                            builder: (active) {
                              if (checkcarouseltwo == false) {
                                return Container(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ));
                              }
                              return CarouselSlider(
                                options: CarouselOptions(
                                  onPageChanged: (i, chang) {
                                    active.changeactive2(i);
                                  },
                                  aspectRatio: 1,
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  autoPlayAnimationDuration:
                                      const Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.linearToEaseOut,
                                  scrollDirection: Axis.horizontal,
                                ),
                                items: carouseltwo.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: CachedNetworkImage(
                                              imageUrl: i,
                                              placeholder: (context, utl) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              },
                                              errorWidget:
                                                  (context, url, error) {
                                                return Container(
                                                    color: Colors.black12,
                                                    child: Icon(Icons.error,
                                                        color: Colors.red));
                                              },
                                            )),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            }),
//////////////////////////////////////////////////////  END Carsoul 2 //////////////////////////////////////////////////////////////////////
                        SizedBox(
                          height: 10,
                        ),
//////////////////////////////////////// AnimatedSmoothIndicator OF CAROUSEL 2/////////////////////////////////
                        GetBuilder<Active>(
                            init: Active(),
                            builder: (active) {
                              return AnimatedSmoothIndicator(
                                activeIndex: active.activeIndex2,
                                count: checkcarouseltwo == false
                                    ? 3
                                    : carouseltwo.length,
                                effect: WormEffect(
                                    dotColor: Colors.grey,
                                    activeDotColor: Colors.blue),
                              );
                            }),

//////////////////////////////////////// END AnimatedSmoothIndicator OF CAROUSEL 2 /////////////////////////////////

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )));
  }
}

//////////////////////////////////////////////////////  activeIndex /////////////////////////////////////////////////////
class Active extends GetxController {
  int activeIndex = 0;
  int activeIndex2 = 0;

  changeactive(change) {
    activeIndex = change;
    update();
  }

  changeactive2(change) {
    activeIndex2 = change;
    update();
  }
}