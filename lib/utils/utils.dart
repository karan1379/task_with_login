import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Utils {
  static showLoader() {
    EasyLoading.show(
      status: "Please Wait...",
      dismissOnTap: false,
      maskType: EasyLoadingMaskType.black,
    );
  }

  static Future hideLoader() async {
    return await EasyLoading.dismiss();
  }

  static errorSnackBar(String? message) {
    if (message == null) {
      return;
    }
    Get.closeAllSnackbars();
    Get.snackbar(
      "Flutter Demo",
      duration:const Duration(seconds: 1),
      message,
      backgroundColor:Colors.blue,
      padding:const EdgeInsets.only(left: 20, bottom: 10),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      borderRadius: 5,
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      titleText: const Text(
        "Flutter Demo",
        textAlign: TextAlign.start,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 18,
            height: 1.6),
      ),
      messageText: Text(
        message,
        textAlign: TextAlign.start,
        style:const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize:18,
            height:1.6),
      ),
    );
  }
  static bool emailValidation(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    return regex.hasMatch(email);
  }
}
