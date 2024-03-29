import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yommie/class/alertDialog.dart';
import 'package:yommie/class/notification.dart';
import 'package:yommie/pages/navigation_bar.dart';
import 'package:yommie/pages/navigation_bar_dummy.dart';
import 'package:yommie/provider/rest.dart';

class LoginViewModels {
  //* login saved session and saved token
  loginPhp(jsons, context) async {
    try {
      var result = await GetAPI.providers(jsons, "login.php");
      var statusCode = result[0];
      var response = result[1];
      if (statusCode == 200) {
        final map = json.decode(response);
        if (map["user_type"] == "user") {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          MyNotification().subcribeMessage(map["userId"], context);
          prefs.setString("userId", map["userId"]);
          prefs.setString("firstName", map["firstname"]);
          prefs.setString("email", map["email"]);
          prefs.setString("token", map["token"]);
          GetAPI.setupHTTPHeader(map["token"]); 
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) =>
                  NavigationBarDummy(userId: map["userId"]),
            ),
          );
        } else {
          DialogAction().alertDialogOneButton(context, "Access Failed !",
              CoolAlertType.error, "Opss this apps only for user.", "Ok", () {
            Navigator.of(context).pop();
          });
        }
      } else {
        final map = json.decode(response);
        String reason = map['reason'];
        String message = map['message'];
        DialogAction().alertDialogOneButton(
            context, message, CoolAlertType.error, reason, "Ok", () {
          Navigator.of(context).pop();
        });
      }
    } catch (e) {
      print(e);
      return e;
    }
  }
}
