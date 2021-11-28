import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';

massage(context) {
  return Timer.run(() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey("welcome") != true) {
      AwesomeDialog(
          context: context,
          autoHide: Duration(seconds: 8),
          dialogType: DialogType.NO_HEADER,
          dialogBorderRadius: BorderRadius.circular(40),
          body: Center(
              child: Column(
            children: [
              Container(
                  width: 40,
                  height: 40,
                  child: Image.asset(
                    "images/logoLauncher.png",
                    fit: BoxFit.contain,
                  )),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "أهلا بك\n تطبيق الحل يتمنى لك الاستفاده من هذا التطبيق ويتمنى ايضا أن يكون عند حسن ضنك",
                  style: TextStyle(color: Colors.blue, fontFamily: "cairo"),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )))
        ..show();
      prefs.setString("welcome", "welcome");
    }
  });
}
