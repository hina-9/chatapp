import 'package:chitchat/Providers/search_provider.dart';
import 'package:chitchat/Providers/shared_preference_provider.dart';
import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Routes/screen_arguements.dart';
import 'package:chitchat/Services/user_database.dart';
import 'package:chitchat/Utils/app_colors.dart';
import 'package:chitchat/Utils/app_constants.dart';
import 'package:chitchat/Utils/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Widget buildResultCard(data) {
  return Consumer2<SearchProvider, SharedPrefProvider>(
    builder: (context, searchprovider, sharedprefprovider, child) {
      return GestureDetector(
        onTap: () async {
          searchprovider.setsearch = false;

          var chatRoomId = HelperFunctions().getChatRoomIdByUser(
              sharedprefprovider.myUsername!, data['username']);
          Map<String, dynamic> chatRoomInfoMap = {
            'users': [sharedprefprovider.myUsername, data['username']]
          };
          await DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
          AppNavigation.navigateTo(
              routeName: AppNavRoutes.chatscreen,
              arguments: ScreenArguments(
                  name: data['name'],
                  profileurl: data['photo'],
                  username: data['username']));
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 2.w),
          child: Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppColors.textWhiteColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Container(
                    height: 7.h,
                    width: 7.h,
                    child: Image.asset(
                      '${AppConstants.assetIcons}user-profile.png',
                    ),
                  ),
                  Gap(2.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['name'],
                        style: TextStyle(
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 17.sp),
                      ),
                      Gap(1.w),
                      Text(
                        data['username'],
                        style: TextStyle(
                            color: AppColors.textBlackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}
