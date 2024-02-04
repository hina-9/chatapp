import 'package:chitchat/Providers/login_providers.dart';

import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Services/user_database.dart';
import 'package:chitchat/SharedPrefernces/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

String name = '', username = '', id = '', pic = '';

userLogin(BuildContext ctx) async {
  print('login');
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Provider.of<LoginProvider>(ctx, listen: false).email,
        password: Provider.of<LoginProvider>(ctx, listen: false).password);
    print('heyyyyyyy${Provider.of<LoginProvider>(ctx, listen: false).email}');
    QuerySnapshot querySnapshot = await DatabaseMethods()
        .getUserByEmail(Provider.of<LoginProvider>(ctx, listen: false).email);
    name = '${querySnapshot.docs[0]['name']}';
    username = '${querySnapshot.docs[0]['username']}';
    pic = '${querySnapshot.docs[0]['photo']}';
    id = '${querySnapshot.docs[0].id}';

    await SharedPreferncesHelper().saveUserDisplayName(name);
    await SharedPreferncesHelper().saveUserName(username);
    await SharedPreferncesHelper().saveUserId(id);
    await SharedPreferncesHelper().saveUserPic(pic);

    AppNavigation.pushAndKillAll(routeName: AppNavRoutes.homescreen);
  } on FirebaseAuthException catch (e) {
    print('code: ${e.code}');
    if (e.code == 'user-not-found') {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Invalid Email', style: TextStyle(fontSize: 17.sp))));
    } else if (e.code == 'wrong-password') {
      print('code: ${e.code}');
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('Wrong Password', style: TextStyle(fontSize: 17.sp))));
    }
  }
}
