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
import 'package:get/get_core/src/get_main.dart';

class ForgetPassword extends StatelessWidget {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
   ForgetPassword({super.key});

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
                  SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/icons/logo.png',
                    width: 40.w,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Forget Password',
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  customFormField(TextInputType.emailAddress, _emailController,
                      context, 'Email', (val) {
                    if (val.isEmpty) {
                      return 'this field can\'t be empty';
                    }

                    if (!RegExp(
                            r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b')
                        .hasMatch(val)) {
                      return 'Enter a valid email address';
                    }
                  }, prefixIcon: Icons.email_outlined),



                
                SizedBox(
                  height: 10,
                ),

                  SizedBox(
                      width: 200.w,
                      height: 45.w,
                      child: customButton('Continue', () {
                        if (_formKey.currentState!.validate()) {
                         
                           Get.find<AuthController>().forgetPassword(
                            _emailController.text.trim(),
                             
                              context
                            );



                        } else
                          print('hi');
                      })),
                  
              
                  SizedBox(
                    height: 20,
                  ),
              
                 
                 
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }


}