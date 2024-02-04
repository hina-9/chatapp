import 'package:chitchat/CustomComponents/CustomTextField.dart';
import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignUpFieldsWidget extends StatelessWidget {
  const SignUpFieldsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name:',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: AppColors.textBlackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        ),
        Gap(1.w),
        CustomTextFormField(
          inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.fieldGreyColor)),
          //  fillColor: AppColors.fieldGreyColor,
          isFilled: true,
          fillColor: AppColors.fieldGreyColor,
          prefixWidget: Icon(
            Icons.account_circle_sharp,
            color: AppColors.primaryColor,
          ),
        ),
        Gap(2.h),
        Text(
          'Email:',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: AppColors.textBlackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        ),
        Gap(1.w),
        CustomTextFormField(
          isFilled: true,
          fillColor: AppColors.fieldGreyColor,
          inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.fieldGreyColor)),
          prefixWidget: Icon(
            Icons.email,
            color: AppColors.primaryColor,
          ),
        ),
        Gap(2.h),
        Text(
          'Password:',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: AppColors.textBlackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        ),
        Gap(1.w),
        CustomTextFormField(
          isFilled: true,
          fillColor: AppColors.fieldGreyColor,
          inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.fieldGreyColor)),
          prefixWidget: Icon(
            Icons.password,
            color: AppColors.primaryColor,
          ),
          obscureText: true,
        ),
        Gap(2.h),
        Text(
          'Confirm Password:',
          textAlign: TextAlign.start,
          style: TextStyle(
              color: AppColors.textBlackColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.w400),
        ),
        Gap(1.w),
        CustomTextFormField(
          isFilled: true,
          fillColor: AppColors.fieldGreyColor,
          inputBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.fieldGreyColor)),
          prefixWidget: Icon(
            Icons.password,
            color: AppColors.primaryColor,
          ),
          obscureText: true,
        ),
        Gap(2.h),
        SizedBox(
          width: 90.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text('Already have an account?'),
              Gap(3.w),
              GestureDetector(
                onTap: () {
                  AppNavigation.navigateTo(
                      routeName: AppNavRoutes.signinscreen);
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
    );
  }
}
