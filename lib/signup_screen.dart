import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_with_login/controller/authentication_controller.dart';
import 'package:task_with_login/utils/utils.dart';


class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController =TextEditingController();
  TextEditingController passwordController =TextEditingController();
  AuthController controller =Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).requestFocus(FocusScopeNode()),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Container(
                   margin: const EdgeInsets.only(bottom: 30),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                     IconButton(
                         onPressed:()
                         {
                           nameController.clear();
                           emailController.clear();
                           passwordController.clear();
                            Get.back();
                         }, icon:Icon(Icons.arrow_back)),
                      Text("Signup".tr,textAlign: TextAlign.center,
                         style:const TextStyle(
                          color: Colors.blue,
                          fontSize: 35,
                          fontWeight: FontWeight.w700
                      ),),
                      const SizedBox(width: 0,height: 0,)
                   ],),
                 ),
                commonTextField(nameController,"Enter Name".tr),
                const SizedBox(height: 20,),
                commonTextField(emailController,"Enter Email".tr),
                const SizedBox(height: 20,),
                commonTextField(passwordController,"Enter Password".tr),
                InkWell(
                  onTap: (){
                    // Get.back();
                    // controller.googleLogin();
                    if(nameController.text.isEmpty){
                      Utils.errorSnackBar("Please enter name".tr);
                      return;
                    }
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
                    if(passwordController.text.length<8){
                      Utils.errorSnackBar("Password must be minimum of 8 digits".tr);
                      return;
                    }
                    controller.addStudent(nameController.text, emailController.text.trim(), passwordController.text.trim());
                  },
                  child: Container(
                    decoration:const BoxDecoration(
                        color: Colors.blue
                    ),
                    margin:const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
                    padding:const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Sign Up".tr),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonTextField(TextEditingController controller,String hintText){
    return Container(
      margin:const EdgeInsets.only(left: 20,right: 20),
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
}
