import 'dart:ffi';

import 'package:ecommerce/business_logics/controllers/auth_controller.dart';
import 'package:ecommerce/const/app_colors.dart';
import 'package:ecommerce/ui/responsive/size_config.dart';
import 'package:ecommerce/ui/route/route.dart';
import 'package:ecommerce/ui/widgets/custom_button.dart';
import 'package:ecommerce/ui/widgets/custom_text_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Registration extends StatelessWidget {
  Registration({super.key});
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  RxBool _value = false.obs;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          
          
          child: Container(
             height: SizeConfig.screenHeight,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                
                children: [
                  SizedBox(height:30 ,),
                  Image.asset(
                    'assets/icons/logo.png',
                    width: 40.w,
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
            
                  SizedBox(height: 20,),

                   customFormField(TextInputType.text, _nameController, context,
                      'Name', (val) {

                        if(val.isEmpty){
                          return 'this field can\'t be empty';
                        }
                      },
                      prefixIcon: Icons.person_2_outlined, obscureText: false),
            
            
                  customFormField(TextInputType.emailAddress, _emailController,
                      context, 'Email', (val) {
                      
                      if(val.isEmpty)
                      {
                        return 'this field can\'t be empty';
                      }

                      
                      if (!RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b').hasMatch(val)) {
                       return 'Enter a valid email address';
                   }
                      },
                      prefixIcon: Icons.email_outlined),





                  customFormField(TextInputType.text, _passwordController, context,
                      'Password', (val) {

                        if (val.isEmpty) {
                           return 'This field can\'t be empty';
                         } else if (val.length < 8) {
                           return 'Password must be at least 8 characters long';
                         }else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$').hasMatch(val)) {
                           return 'Password must contain at least one uppercase letter, one lowercase letter, and one digit';
    }
                      },
                      prefixIcon: Icons.remove_red_eye_outlined, obscureText: true),
            





                 Row(
                   children: [
                     Obx(() =>      
                      Checkbox(value: _value.value, onChanged: (val){
                        _value.value=val!;
                      })
                        ),


                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: 'I accept all the',
                        style: TextStyle(
                            color: AppColors.grayColor, fontWeight: FontWeight.w600)),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=() => Get.toNamed(terms) ,
                        text: '    Terms and Conditions',
                    
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600))
                  ]))

    



                   ],
                 ),






                       SizedBox(height: 30,),
                  SizedBox(
                      width: 200.w,
                      height: 45.w,
                      child: customButton('Sign Up', () {
                        if(_formKey.currentState!.validate()&&_value.value==true){
                          Get.find<AuthController>().signUp(_nameController.text, _emailController.text.trim(), _passwordController.text.trim(), context);
                        }
                        else print('hi');
                      })),
            
            
                      SizedBox(height:20,),
            
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      ),
                      Text('  OR  '),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
            
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {},
                        child: Ink(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.grayColor.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset('assets/icons/facebook.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(50),
                        onTap: () {},
                        child: Ink(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColors.grayColor.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3))
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset('assets/icons/search.png'),
                          ),
                        ),
                      )
                    ],
                  ),
            
                  SizedBox(height: 20,),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: 'Already have an account?',
                        style: TextStyle(
                            color: AppColors.grayColor, fontWeight: FontWeight.w600)),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=() => Get.toNamed(login) ,
                        text: '    Login',
                    
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w600))
                  ]))
                ],
                    
              ),
            ),
          ),
                ),
          
          
          
          
              )),
    );
  }
}
