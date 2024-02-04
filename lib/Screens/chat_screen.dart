import 'package:chitchat/Routes/app_navigation.dart';
import 'package:chitchat/Routes/screen_arguements.dart';
import 'package:chitchat/Services/user_database.dart';
import 'package:chitchat/SharedPrefernces/shared_preferences.dart';
import 'package:chitchat/Utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:random_string/random_string.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  final ScreenArguments data;
  const ChatScreen({super.key, required this.data});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messagecontroller = TextEditingController();
  String? myUserName, myProfilePic, myName, myEmail, msgId, chatRoomId;
  Stream? messageStream;

  getChatRoomIdByUser(String? a, String? b) {
    if (a!.substring(0, 1).codeUnitAt(0) > b!.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget chatMessageTile(String msg, bool sendByMe, String ts) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          padding: EdgeInsets.all(2.h),
          margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.w),
          decoration: BoxDecoration(
              color:
                  sendByMe ? AppColors.sendMsgColor : AppColors.recieveMsgColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0))),
          child: Text(
            msg,
            style: TextStyle(
                color: AppColors.textBlackColor,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp),
          ),
        ))
      ],
    );
  }

  Widget chatMessage() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  padding: EdgeInsets.only(bottom: 10.h, top: 15.h),
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                  itemBuilder: (ctx, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return chatMessageTile(
                        ds['message'], myUserName == ds['sendBy'], ds['ts']);
                  })
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  getthesharedpref() async {
    myName = await SharedPreferncesHelper().getUserDisplayName();
    myEmail = await SharedPreferncesHelper().getUserEmail();
    myProfilePic = await SharedPreferncesHelper().getUserPic();
    myUserName = await SharedPreferncesHelper().getUserName();
    chatRoomId = getChatRoomIdByUser(widget.data.username, myUserName);
    setState(() {});
  }

  ontheload() async {
    await getthesharedpref();
    getAndSetMessages();
    setState(() {});
  }

  void initState() {
    super.initState();
    ontheload();
  }

  addMessage(bool sendClicked) {
    if (messagecontroller.text != '') {
      String message = messagecontroller.text;
      messagecontroller.text = '';
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('h:mma').format(now);
      Map<String, dynamic> messageInfoMap = {
        'message': message,
        'sendBy': myUserName,
        'ts': formattedDate,
        'time': FieldValue.serverTimestamp(),
        'imgUrl': myProfilePic
      };
      msgId ??= randomAlphaNumeric(10);

      DatabaseMethods()
          .addMessage(chatRoomId!, msgId!, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          'lastMessage': message,
          'lastMessageSendTs': formattedDate,
          'time': FieldValue.serverTimestamp(),
          'lastMessageSendBy': myUserName
        };
        DatabaseMethods()
            .updateLastMessageSend(chatRoomId!, lastMessageInfoMap);
        if (sendClicked) {
          msgId = null;
        }
      });
    }
  }

  getAndSetMessages() async {
    messageStream = await DatabaseMethods().getChatRoomMessage(chatRoomId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Container(
        padding: EdgeInsets.only(top: 4.h),
        child: Stack(
          children: [
            Container(
                // alignment: Alignment.center,
                margin: EdgeInsets.only(top: 5.h),
                height: 90.h,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Theme.of(context).colorScheme.background),
                child: chatMessage()),
            Padding(
              padding: EdgeInsets.only(left: 4.w),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        AppNavigation.goBack();
                      },
                      child: Icon(Icons.arrow_back_ios_outlined)),
                  Gap(10.w),
                  Text(
                    '${widget.data.name}'.toUpperCase(),
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 2.h, right: 2.h, bottom: 2.h),
              alignment: Alignment.bottomCenter,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(30),
                child: Container(
                    alignment: Alignment.center,
                    height: 7.h,
                    //margin: EdgeInsets.only(left: .h, right: 2.h, bottom: 2.h),
                    padding: EdgeInsets.all(2.h),
                    decoration: BoxDecoration(
                      color: AppColors.textWhiteColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      style: TextStyle(color: AppColors.textBlackColor),
                      controller: messagecontroller,
                      decoration: InputDecoration(
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        enabledBorder:
                            UnderlineInputBorder(borderSide: BorderSide.none),
                        border: InputBorder.none,
                        hintText: 'Type a Message...',
                        hintStyle: TextStyle(
                            color: AppColors.textBlackColor, fontSize: 16.sp),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            addMessage(true);
                          },
                          child: Icon(
                            Icons.send_rounded,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
