
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_with_login/helper/routes/routes.dart';
import 'package:task_with_login/helper/shared_prefrence_helper.dart';
import 'package:task_with_login/model/user_model.dart';
import 'package:task_with_login/utils/utils.dart';


class AuthController extends GetxController{

  late SharedPreferenceHelper preferenceHelper;
  CollectionReference students = FirebaseFirestore.instance.collection('users');
  RxList<UserModel> usersList = RxList();
  var selectedLanguage = "English".obs;


  @override
  void onInit() {
   preferenceHelper=SharedPreferenceHelper();
    super.onInit();
  }

  set changeLanguage(String lang) {
    Locale locale = new Locale(lang);
    Get.updateLocale(locale);
    selectedLanguage.value = lang;
  }


  Future<void> addStudent(String fullName,String email,String password) {
    // Calling the collection to add a new user
    return students
    //adding to firebase collection
        .add({
      //Data added in the form of a dictionary into the document.
      'name': fullName,
      'email': email,
      'password': password
    })
        .then((value) {
      Get.offAllNamed(Routes.bottomNavigationBar);
      preferenceHelper.saveIsLoggedIn(true);


    })
        .catchError((error) => print("Student couldn't be added."));
  }

  Future<void> getStudent() {
    return students.get().then((value) {
      final allData = value.docs.map((doc) => doc.data()).toList();
            List<dynamic> list = allData;
            usersList.clear();
            for (var element in list) {
              usersList.add(UserModel.fromJson(element as Map<String, dynamic>));
            }
    })
        .catchError((error) => print("Student couldn't be added."));
  }

  Future<void> login(String email,String password)async {
    Utils.showLoader();
    for(var item in usersList){
      if(email==item.email && password ==  item.password){
        preferenceHelper.saveIsLoggedIn(true);
        Utils.hideLoader();
        Get.offAllNamed(Routes.bottomNavigationBar);
      }else{
        Utils.hideLoader();
        // Utils.errorSnackBar("Please check creds");
        Get.showSnackbar(GetSnackBar(message: "No User Found",));
      }
    }
  }

  Future<void> logout() async {
    try {
      Get.offAllNamed(Routes.login);
      preferenceHelper.clearAll();
    } catch (error) {
      print(error);
    }
  }
}