import 'package:chitchat/CustomComponents/CustomButton.dart';
import 'package:chitchat/CustomComponents/CustomTextField.dart';
import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Utils/app_colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  String email = '';

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Text('Reset Password link Sent to Email',
              style: TextStyle(fontSize: 17.sp))));
    } on FirebaseAuthException catch (e) {
      print('code: ${e.code}');
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text('Invalid Email', style: TextStyle(fontSize: 17.sp))));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: 100.h,
          width: 100.w,
          child: Stack(
            children: [
              Container(
                height: 30.h,
                width: 100.w,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [AppColors.primaryColor, Color(0xff4F6F52)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(80.w, 10.h))),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Center(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Password Recovery',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.textWhiteColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Enter Email to Reset Password',
                        style: TextStyle(
                            color: AppColors.textWhiteColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w400),
                        //textAlign: TextAlign.center,
                      ),
                      Gap(5.h),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        elevation: 8,
                        color: AppColors.textWhiteColor,
                        child: Container(
                          width: 85.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.textWhiteColor),
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: SizedBox(
                              child: Form(
                                key: _formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(1.h),
                                    Text(
                                      'Email:',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.textBlackColor,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Gap(1.w),
                                    CustomTextFormField(
                                      controller: emailController,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Please enter email';
                                        } else
                                          return null;
                                      },
                                      isFilled: true,
                                      fillColor: AppColors.fieldGreyColor,
                                      inputBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          borderSide: BorderSide(
                                              color: AppColors.fieldGreyColor)),
                                      prefixWidget: Icon(
                                        Icons.email,
                                        color: AppColors.primaryColor,
                                      ),
                                    ),

                                    Spacer(),
                                    Center(
                                      child: CustomButton(
                                          text: 'Send Email',
                                          textColor: AppColors.textWhiteColor,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          onPress: () {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              setState(() {
                                                email = emailController.text;
                                              });
                                              resetPassword();
                                            }
                                          },
                                          buttonHeight: 8.h,
                                          buttonWidth: 85.w),
                                    ),
                                    // Gap(3.h),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Gap(2.h),
                      SizedBox(
                        width: 85.w,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Don\'t have an Account?'),
                            Gap(3.w),
                            GestureDetector(
                              onTap: () {
                                AppNavigation.navigateTo(
                                    routeName: AppNavRoutes.signupscreen);
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
