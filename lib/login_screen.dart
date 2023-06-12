import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_with_login/controller/authentication_controller.dart';
import 'package:task_with_login/helper/routes/routes.dart';
import 'package:task_with_login/utils/utils.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key){
    controller.getStudent();
  }
   AuthController controller =Get.put(AuthController());
   TextEditingController emailController =TextEditingController();
   TextEditingController passwordController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       body: GestureDetector(
         behavior: HitTestBehavior.translucent,
         onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
              Text("Login".tr,style:const TextStyle(
               color: Colors.blue,
               fontSize: 35,
               fontWeight: FontWeight.w700
             ),),
             const SizedBox(
               height: 20,
             ),
             commonTextField(emailController,"Enter Email".tr),
            const SizedBox(height: 20,),
             commonTextField(passwordController,"Enter Password".tr),
             InkWell(
               onTap: (){
                 if(emailController.text.trim().isEmpty){
                   Utils.errorSnackBar("Please Enter Email".tr);
                   return;
                 }
                 if(!Utils.emailValidation(emailController.text)){
                   Utils.errorSnackBar("Please Enter valid Email".tr);
                   return;
                 }
                 if(passwordController.text.isEmpty){
                   Utils.errorSnackBar("Please Enter Password".tr);
                   return;
                 }
                controller.login(emailController.text.trim(), passwordController.text.trim());
               },
               child: Container(
                 decoration:const BoxDecoration(
                     color: Colors.blue
                 ),
                 margin:const  EdgeInsets.symmetric(vertical: 30,horizontal: 20),
                 padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                 child:Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                      Text("Sign In".tr,style:const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500
                      ),),
                   ],
                 ),
               ),
             ),
             Container(
               margin:const EdgeInsets.only(right: 20),
                 alignment: Alignment.bottomRight,
                 child: Text("Forgot Password".tr,style:const TextStyle(
                   color: Colors.black,fontWeight: FontWeight.w500,fontSize: 14
                 ),)),
             InkWell(
               onTap: (){
                 emailController.clear();
                 passwordController.clear();
                 Get.toNamed(Routes.signup);
               },
               child: Container(
                 margin:const  EdgeInsets.only(left: 20,right: 20,top: 20),
                 padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                  decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text("Sign Up".tr,style:const TextStyle(
                       fontSize: 18,
                       color: Colors.blue,
                       fontWeight: FontWeight.w500
                     ),),
                   ],
                 ),
               ),
             ),
           ],
         ),
       ),
    );
  }

  Widget commonTextField(TextEditingController controller,String hintText){
     return Container(
       margin:const  EdgeInsets.only(left: 20,right: 20),
       child: TextFormField(
          controller: controller,
         decoration: InputDecoration(
           hintText:hintText,
           border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
           ),
             enabledBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10)
             ),
             focusedBorder: OutlineInputBorder(
                 borderRadius: BorderRadius.circular(10)
             )
         ),
       ),
     );
  }
  // DropdownButton languageChooser() {
  //   return DropdownButton<String>(
  //       isExpanded: false,
  //       hint: Text('Please choose a location'), // Not necessary for Option 1
  //       value: controller.selectedLanguage?.value,
  //       onChanged: (symbol) {
  //         controller.changeLanguage = symbol??"";
  //       },
  //       items: languages.map((LanguageModel _language) {
  //         print(_language.language);
  //         return DropdownMenuItem<String>(
  //           child: new Text(_language.language),
  //           value: _language.symbol,
  //         );
  //       }).toList());
  // }
}
