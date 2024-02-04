import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/app_navigation_routes.dart';
import 'package:chitchat/Routes/screen_arguements.dart';
import 'package:chitchat/Services/user_database.dart';
import 'package:chitchat/Utils/helper_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatRoomListTile extends StatefulWidget {
  final String lastMsg, chatRoomId, myUsername, time;
  const ChatRoomListTile(
      {super.key,
      required this.chatRoomId,
      required this.lastMsg,
      required this.myUsername,
      required this.time});

  @override
  State<ChatRoomListTile> createState() => _ChatRoomListTileState();
}

class _ChatRoomListTileState extends State<ChatRoomListTile> {
  String profilePicUrl = '', name = '', username = '', id = '';

  getThisUserInfo() async {
    username =
        widget.chatRoomId.replaceAll('_', '').replaceAll(widget.myUsername, '');
    QuerySnapshot qs =
        await DatabaseMethods().getUserInfo(username.toUpperCase());
    name = '${qs.docs[0]['name']}';
    profilePicUrl = '${qs.docs[0]['photo']}';
    id = '${qs.docs[0]['Id']}';
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        setState(() {});
        var chatRoomId =
            HelperFunctions().getChatRoomIdByUser(widget.myUsername, username);
        Map<String, dynamic> chatRoomInfoMap = {
          'users': [widget.myUsername, username]
        };
        await DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);
        AppNavigation.navigateTo(
            routeName: AppNavRoutes.chatscreen,
            arguments: ScreenArguments(
                name: username,
                profileurl: 'assets/icons/user-profile.png',
                username: username));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(60),
                child: Image.asset(
                  'assets/icons/user-profile.png',
                  height: 6.h,
                  width: 6.h,
                  fit: BoxFit.cover,
                )),
            Gap(2.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  username,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 50.w,
                  child: Text(widget.lastMsg,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.time,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
