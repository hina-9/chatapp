import 'package:chitchat/Services/user_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  bool _search = false;

  bool get search => _search;

  var queryResultSet = [];
  var tempSearchStore = [];

  String? myName, myEmail, myPic, myUsername;

  set setsearch(bool search) {
    _search = search;
    notifyListeners();
  }

  initiateSearch(value) {
    if (value.length == 0) {
      queryResultSet = [];
      tempSearchStore = [];
    }
    notifyListeners();
    _search = true;

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);
    if (queryResultSet.isEmpty && value.length == 1) {
      DatabaseMethods().search(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(docs.docs[i].data());
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['username'].startsWith(capitalizedValue)) {
          tempSearchStore.add(element);
          notifyListeners();
        }
      });
    }
  }
}
