import 'package:chitchat/Services/user_database.dart';
import 'package:chitchat/SharedPrefernces/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPrefProvider extends ChangeNotifier {
  String? _myName, _myEmail, _myPic, _myUsername;
  Stream? _chatRoomStream;

  Stream? get chatRoomStream => _chatRoomStream;

  String? get myName => _myName;
  String? get myEmail => _myEmail;
  String? get myPic => _myPic;
  String? get myUsername => _myUsername;

  setStream() async {
    _chatRoomStream = await DatabaseMethods().getChatRooms();
  }

  getthesharedpref() async {
    _myName = await SharedPreferncesHelper().getUserDisplayName();
    _myEmail = await SharedPreferncesHelper().getUserEmail();
    _myPic = await SharedPreferncesHelper().getUserPic();
    _myUsername = await SharedPreferncesHelper().getUserName();
    notifyListeners();
  }
}
