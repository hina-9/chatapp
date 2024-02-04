import 'package:chitchat/CustomComponents/CustomTextField.dart';
import 'package:chitchat/CustomComponents/search_result_card.dart';
import 'package:chitchat/CustomWidgets/chatrooms_list.dart';
import 'package:chitchat/Providers/search_provider.dart';
import 'package:chitchat/Providers/shared_preference_provider.dart';
import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Utils/app_colors.dart';
import 'package:chitchat/Utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  onload() async {
    await Provider.of<SharedPrefProvider>(context, listen: false)
        .getthesharedpref();
  }

  @override
  void initState() {
    super.initState();
    onload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Consumer2<SearchProvider, SharedPrefProvider>(
          builder: (context, searchprovider, sharedprefprovider, child) {
            return Column(children: [
              Container(
                height: 10.h,
                width: 100.w,
                decoration: BoxDecoration(color: AppColors.primaryColor),
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(2.w),
                    searchprovider.search
                        ? Padding(
                            padding: EdgeInsets.only(top: 3.h),
                            child: SizedBox(
                              width: 80.w,
                              child: CustomTextFormField(
                                textColor: AppColors.textBlackColor,
                                textStyle: TextStyle(fontSize: 17.sp),
                                onChange: (v) {
                                  searchprovider
                                      .initiateSearch(v!.toUpperCase());
                                },
                                hintText: 'Search User',
                                hintStyle: TextStyle(
                                    color: AppColors.textBlackColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                                inputBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          )
                        : Text(
                            '  ChitChat',
                            style: TextStyle(
                                fontSize: 20.sp, fontWeight: FontWeight.bold),
                          ),
                    Spacer(),
                    GestureDetector(
                        onTap: () {
                          searchprovider.setsearch = true;
                        },
                        child: Container(
                            alignment: Alignment.center,
                            // padding: EdgeInsets.all(1w),
                            height: 7.h,
                            width: 7.w,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 17, 65, 35),
                                shape: BoxShape.circle),
                            child: searchprovider.search
                                ? GestureDetector(
                                    onTap: () {
                                      searchprovider.setsearch = false;
                                    },
                                    child: Icon(
                                      Icons.close,
                                      size: 5.w,
                                      color: AppColors.textWhiteColor,
                                    ))
                                : Icon(
                                    Icons.search,
                                    size: 5.w,
                                    color: AppColors.textWhiteColor,
                                  ))),
                    Gap(2.w),
                    GestureDetector(
                      onTap: () {
                        AppNavigation.navigateTo(
                            routeName: AppNavRoutes.profilescreen);
                      },
                      child: SizedBox(
                        height: 3.h,
                        child: Image.asset(
                          '${AppConstants.assetIcons}dots.png',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              searchprovider.search
                  ? ListView(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.w, horizontal: 2.w),
                      primary: false,
                      shrinkWrap: true,
                      children: searchprovider.tempSearchStore.map((element) {
                        return buildResultCard(element);
                      }).toList())
                  : ChatRoomsList(),
            ]);
          },
        ));
  }
}
