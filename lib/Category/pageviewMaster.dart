import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_solution/Category/category.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:the_solution/Category/pageview.dart';
import 'package:the_solution/Home/compontes/animation/animationOFnavigator.dart';


class PageviewMaster extends StatefulWidget {
var title ;
var id;
  PageviewMaster(this.id,this.title);

  @override
  _PageviewMasterState createState() => _PageviewMasterState();
}

class _PageviewMasterState extends State<PageviewMaster> {
var network;
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

  stream: FirebaseFirestore.instance.collection("Category").doc(widget.id).collection("children").snapshots(),
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
    Navigator.push(context,animation(widget:Pageview(snapshot.data!.docs[i].id, snapshot.data!.docs[i]["url"],widget.id),direction: AxisDirection.down));

        },
        child: Card(          
               color:Colors.grey[100],
        
                 elevation: 8,
         
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             Card(
               elevation: 8,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
         
               child: Container(
                 height: 100,
                        //  width: 200,
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(25),
                           child:  CachedNetworkImage(imageUrl: "${snapshot.data!.docs[i]["url"]}",placeholder: (context,utl){
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
                         )
                         ,
                         ),
             ),
             
                       Text("${snapshot.data!.docs[i]["title"]}",style: TextStyle(color: Colors.black,fontFamily: "cairo") )
          ],),
       decoration: BoxDecoration(
               color:Colors.grey[100],
          image: DecorationImage(image:AssetImage("images/pageview.jpg"),fit: BoxFit.fill),
         
       borderRadius: BorderRadius.circular(20)
       ),
          ),
        ),
        ),
         );
       
       
       
       });
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
      
     Text("${widget.title}",style :TextStyle(color: Colors.white,fontFamily: "cairo",shadows: [Shadow(
    color: Colors.black,
    blurRadius: 4,
  )])),
Card(
elevation: 10,
shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(500)),child:Container(width:35,height: 35,
child:ClipRRect(child: Image.asset("images/drawerlogo.jpg",fit:BoxFit.cover),borderRadius: BorderRadius.circular(500),),),
)


    ],
  ),
  height: 140,
  width: MediaQuery.of(context).size.width,
  decoration: BoxDecoration(
borderRadius: BorderRadius.circular(20),
boxShadow: [BoxShadow(color: Colors.black,blurRadius: 10)],




        image: DecorationImage(image:AssetImage("images/pageview.jpg"),fit: BoxFit.fill),

  
),),

     ],
   )





///////////////////////////////////////////////////////////// END  Body /////////////////////////////////////////////////////////

      
    );
}}