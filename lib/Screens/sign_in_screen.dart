import 'package:chitchat/CustomComponents/CustomButton.dart';
import 'package:chitchat/CustomComponents/CustomTextField.dart';
import 'package:chitchat/Providers/login_providers.dart';

import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Services/login.dart';
import 'package:chitchat/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<LoginProvider>(builder: (context, loginProvider, child) {
      return SingleChildScrollView(
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
                        'Welcom Back',
                        //textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.textWhiteColor,
                            fontSize: 21.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Login to your Account',
                        style: TextStyle(
                            color: AppColors.textWhiteColor,
                            fontSize: 19.sp,
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
                          height: 45.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColors.textWhiteColor),
                          child: Padding(
                            padding: EdgeInsets.all(2.h),
                            child: SizedBox(
                              child: Form(
                                key: loginProvider.userFormKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Gap(1.h),
                                    Text(
                                      'Email:',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.textBlackColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Gap(1.w),
                                    CustomTextFormField(
                                      controller: loginProvider.emailcontroller,
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
                                    Gap(1.h),
                                    Text(
                                      'Password:',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.textBlackColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Gap(1.w),
                                    CustomTextFormField(
                                      controller: loginProvider.passcontroller,
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Please enter password';
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
                                        Icons.password,
                                        color: AppColors.primaryColor,
                                      ),
                                      obscureText: true,
                                    ),
                                    Gap(1.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            AppNavigation.navigateTo(
                                                routeName: AppNavRoutes
                                                    .forgotpassscreen);
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: AppColors.primaryColor),
                                            textAlign: TextAlign.end,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Center(
                                      child: CustomButton(
                                          text: 'SIGN IN',
                                          textColor: AppColors.textWhiteColor,
                                          backgroundColor:
                                              AppColors.primaryColor,
                                          onPress: () {
                                            if (loginProvider
                                                .userFormKey.currentState!
                                                .validate()) {
                                              print('am called');
                                              loginProvider.matchCredentials();
                                              userLogin(context);
                                              print('am logincalled');
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
      );
    }));
  }
}
