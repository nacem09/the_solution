import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_solution/Category/pageviewMaster.dart';
import 'package:the_solution/Home/compontes/animation/animationOFnavigator.dart';
import 'package:the_solution/Home/compontes/drawer.dart';
import 'package:the_solution/Home/home.dart';

class category extends StatefulWidget {

category({Key? key}) : super(key: key);

  @override
  _categoryState createState() => _categoryState();
}

class _categoryState extends State<category> {
var network;
GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  CollectionReference user =FirebaseFirestore.instance.collection("Category");
  
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    }
  

  @override
  Widget build(BuildContext context) {
    Connectivity().onConnectivityChanged.listen((event) { 

setState(() {
  network=event;
});
    });
    return Scaffold( 
      key:  _scaffoldkey,
///////////////////////////////////////////////// DRAWER  ////////////////////////////////////////////////////////////////
endDrawer: drawer(),
/////////////////////////////////////////////////END  DRAWER  ////////////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////// Body /////////////////////////////////////////////////////////
body: 
network ==ConnectivityResult.none?
        Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off,color:Colors.red),
            Text("لقد فقدت الاتصال بالانترنت",style:TextStyle(fontFamily: "Amiri",color:Colors.black))
          ],),
        ):
   Stack(
     children: [
Container(
  color: Colors.white,
  width: MediaQuery.of(context).size.width,
  height: MediaQuery.of(context).size.height,

),
//////////////////////////////////////////////////////////// GRID VIEW /////////////////////////////////////////////////////////////////////////
StreamBuilder(

  stream: user.snapshots(),
  builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
  if(snapshot.hasError){
       return Text("Erorr");//كان في خطا يقولك في خطا
     }
     ///////////////////////////////////////////////////////// Has data //////////////////////////////////////////////////
     if(snapshot.hasData){//كان في بياناتا يعرضلك هذي
       return  GridView.builder(
         itemCount: snapshot.data!.docs.length,
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
  physics: BouncingScrollPhysics(),  padding: const EdgeInsets.only(top: 160,),
  itemBuilder: (context,i){
    return InkWell(
  onTap: (){
    Navigator.push(context,animation(widget:PageviewMaster(snapshot.data!.docs[i].id, snapshot.data!.docs[i]["title"]),direction: AxisDirection.left));

  },
       child: 
       Card(
  
                   elevation: 8,
  
       shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(50),),
  
                   child: Container(
                                       
                       child: Column(
                         
                       children:
                       [
                       Container(
                      
 child: CachedNetworkImage(imageUrl: "${snapshot.data!.docs[i]["imageurl"]}",placeholder: (context,utl){
return Center(
  child: CircularProgressIndicator(),
);
     },
     errorWidget: (context,url,error){
       return Container(
         color: Colors.black12,
         child:Icon(Icons.error,color:Colors.red)
       );
     },
                         )
                         ,
                         ),
                         
                          Text(
                            "${snapshot.data!.docs[i]["title"]}",overflow: TextOverflow.ellipsis,
                            style :TextStyle(fontSize: 15,
                            color: Colors.blue,fontFamily: "cairo",
  //                           shadows: [Shadow(
  //   color: Colors.black,
  //   blurRadius: 1,
  // )]
  )),
                     ]),
  margin: EdgeInsets.only(bottom: 5),
                   
                 decoration: BoxDecoration(image: DecorationImage(image:AssetImage("images/drawercategory.jpg"),fit: BoxFit.cover),
  
                     borderRadius: BorderRadius.circular(50),),
  
                   ),
                 ),
     );
  },

  );
 /////////////////////////////////////////////////////////  END Has data //////////////////////////////////////////////////

     }
     return Center(child: CircularProgressIndicator(),);//الشرطين متحققنش ايدرين هذي 
  }),
////////////////////////////////////////////////////////////  END GRID VIEW /////////////////////////////////////////////////////////////////////////
Container(
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      IconButton(onPressed: (){
       Get.back();
      }, icon: Icon(Icons.keyboard_return,color:Colors.white)),
      
     Text("الأقسام",style :TextStyle(color: Colors.white,fontFamily: "cairo",shadows: [Shadow(
    color: Colors.black,
    blurRadius: 4,
  )])),
              IconButton(onPressed: (){
                _scaffoldkey.currentState!.openEndDrawer();
              }, icon: Icon(Icons.category,color:Colors.white,),)


    ],
  ),
  height: 180,
  width: MediaQuery.of(context).size.width,
  decoration: BoxDecoration(





        image: DecorationImage(image:AssetImage("images/SHC5.png"),fit: BoxFit.fill),

  
),),

     ],
   )





///////////////////////////////////////////////////////////// END  Body /////////////////////////////////////////////////////////

      
    );
  }}
