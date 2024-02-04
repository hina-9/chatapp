import 'package:chitchat/Providers/login_providers.dart';
import 'package:chitchat/Providers/theme_provider.dart';
import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isHide = true;

  void showPass() {
    isHide = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Consumer2<ThemeProvider, LoginProvider>(
        builder: (context, themeprovide, loginprovider, child) {
          return Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.,
              children: [
                Gap(10.h),
                Container(
                  height: 15.h,
                  width: 15.h,
                  child: Image.asset('assets/icons/user-profile.png'),
                ),
                Gap(2.h),
                Container(
                  width: 70.w,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Name ',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Gap(4.w),
                          Text(
                              '${loginprovider.email.replaceAll('@gmail.com', '')}'),
                        ],
                      ),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email ',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Gap(4.w),
                          Text('${loginprovider.email}'),
                        ],
                      ),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Password ',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Spacer(),
                          isHide
                              ? Text('********')
                              : Text(
                                  '${loginprovider.password.replaceAll('@gmail.com', '')}'),
                          isHide
                              ? IconButton(
                                  icon: Icon(Icons.remove_red_eye_outlined),
                                  onPressed: () {
                                    isHide = false;
                                    setState(() {});
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {
                                    isHide = true;
                                    setState(() {});
                                  },
                                )
                        ],
                      ),
                      Gap(2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dark Mode',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w800),
                          ),
                          Gap(4.w),
                          CupertinoSwitch(
                              value: themeprovide.isDarkMode,
                              onChanged: (value) {
                                themeprovide.toggleTheme();
                              })
                        ],
                      ),
                      Gap(2.h),
                      GestureDetector(
                        onTap: () {
                          AppNavigation.pushAndKillAll(
                              routeName: AppNavRoutes.signupscreen);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Logout',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800),
                            ),
                            Gap(4.w),
                            Icon(Icons.logout)
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
