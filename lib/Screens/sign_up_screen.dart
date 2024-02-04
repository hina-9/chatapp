import 'package:chitchat/CustomComponents/CustomButton.dart';
import 'package:chitchat/CustomComponents/CustomTextField.dart';
import 'package:chitchat/Providers/registration_provider.dart';
import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Services/registration.dart';
import 'package:chitchat/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer<RegistrationProvider>(
        builder: (context, registerationProvider, child) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 100.h,
              width: 100.w,
              child: Stack(
                children: [
                  Container(
                    height: 25.h,
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
                    padding: EdgeInsets.only(top: 5.h),
                    child: Center(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'SignUp',
                            //textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColors.textWhiteColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Create a new Account ',
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
                            //  color: AppColors.textWhiteColor,
                            child: Container(
                              width: 85.w,
                              height: 62.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.textWhiteColor),
                              child: Padding(
                                padding: EdgeInsets.all(2.h),
                                child: SizedBox(
                                    child: Form(
                                  key: registerationProvider.userFormKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Name:',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.textBlackColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Gap(1.w),
                                      CustomTextFormField(
                                        controller: registerationProvider
                                            .namecontroller,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return 'Please enter name';
                                          } else
                                            return null;
                                        },
                                        inputBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.fieldGreyColor)),
                                        //  fillColor: AppColors.fieldGreyColor,
                                        isFilled: true,
                                        fillColor: AppColors.fieldGreyColor,
                                        prefixWidget: Icon(
                                          Icons.account_circle_sharp,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
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
                                        controller: registerationProvider
                                            .emailcontroller,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return 'Please enter E-mail';
                                          } else
                                            return null;
                                        },
                                        isFilled: true,
                                        fillColor: AppColors.fieldGreyColor,
                                        inputBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.fieldGreyColor)),
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
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Gap(1.w),
                                      CustomTextFormField(
                                        controller: registerationProvider
                                            .passcontroller,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return 'Please set password';
                                          } else if (v.length < 8) {
                                            return 'Enter maximum 8 characters';
                                          } else
                                            return null;
                                        },
                                        isFilled: true,
                                        fillColor: AppColors.fieldGreyColor,
                                        inputBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.fieldGreyColor)),
                                        prefixWidget: Icon(
                                          Icons.password,
                                          color: AppColors.primaryColor,
                                        ),
                                        obscureText: true,
                                      ),
                                      Gap(1.h),
                                      Text(
                                        'Confirm Password:',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.textBlackColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Gap(1.w),
                                      CustomTextFormField(
                                        controller: registerationProvider
                                            .confirmpasscontroller,
                                        validator: (v) {
                                          if (v == null || v.isEmpty) {
                                            return 'Please enter confirm password';
                                          } else
                                            return null;
                                        },
                                        isFilled: true,
                                        fillColor: AppColors.fieldGreyColor,
                                        inputBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            borderSide: BorderSide(
                                                color:
                                                    AppColors.fieldGreyColor)),
                                        prefixWidget: Icon(
                                          Icons.password,
                                          color: AppColors.primaryColor,
                                        ),
                                        obscureText: true,
                                      ),
                                      Spacer(),
                                      SizedBox(
                                        width: 90.w,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text('Already have an account?'),
                                            Gap(3.w),
                                            GestureDetector(
                                              onTap: () {
                                                AppNavigation.navigateTo(
                                                    routeName: AppNavRoutes
                                                        .signinscreen);
                                              },
                                              child: Text(
                                                'Sign In',
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
                                )),
                              ),
                            ),
                          ),
                          Spacer(),
                          CustomButton(
                              borderColor: AppColors.primaryColor,
                              text: 'SIGN UP',
                              textColor: AppColors.textWhiteColor,
                              backgroundColor: AppColors.primaryColor,
                              onPress: () async {
                                if (registerationProvider
                                    .userFormKey.currentState!
                                    .validate()) {
                                  print('am called');
                                  setState(() {});
                                  registerationProvider.saveCredentials();
                                }
                                await registration(context);
                              },
                              buttonHeight: 8.h,
                              buttonWidth: 85.w),
                          Gap(7.h),

                          // Gap(7.h),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
