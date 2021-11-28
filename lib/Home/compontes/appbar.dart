import 'dart:async';

import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:the_solution/Home/home.dart';
import 'package:the_solution/Home/compontes/animation/animationOFrefrech.dart';

appbar(context) {
  return AppBar(
      actions: [
        ///////////////////////////////////////////////////////////// REFRACH iCON////////////////////////////////
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
              onPressed: () {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.NO_HEADER,
                    dialogBorderRadius: BorderRadius.circular(40),
                    body: Padding(
                      padding: const EdgeInsets.only(bottom: 20, top: 20),
                      child: Center(child: CircularProgressIndicator()),
                    ))
                  ..show();
                Timer(Duration(seconds: 2), () {
                  Navigator.of(context).pushAndRemoveUntil(
                      refrech(widget: Home()), (route) => false);
                });
              },
              icon: Icon(Icons.refresh)),
        )
        ///////////////////////////////////////////////////////////// END REFRACH iCON////////////////////////////////
      ],
      backgroundColor: Colors.blue[600],
      centerTitle: true,
      title: Text(
        "الصفحة الرئيسية",
        style: Theme.of(context).textTheme.bodyText2,
      ),
      elevation: 10,
      shadowColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35), bottomRight: Radius.circular(35)),
      ));
}
