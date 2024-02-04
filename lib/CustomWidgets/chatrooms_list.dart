import 'package:chitchat/CustomComponents/chat_room_list_tile.dart';
import 'package:chitchat/Providers/shared_preference_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget ChatRoomsList() {
  return Consumer<SharedPrefProvider>(
    builder: (context, sharedprefprovider, child) {
      return StreamBuilder(
          stream: sharedprefprovider.chatRoomStream,
          builder: (ctx, AsyncSnapshot snapshot) {
            return snapshot.hasData
                ? ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: snapshot.data.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      //docs.....................
                      DocumentSnapshot ds = snapshot.data.docs[index];
                      return ChatRoomListTile(
                          chatRoomId: ds.id,
                          lastMsg: ds['lastMessage'],
                          myUsername: sharedprefprovider.myUsername!,
                          time: ds['lastMessageSendTs']);
                    })
                : Center(
                    child: CircularProgressIndicator(),
                  );
          });
    },
  );
}
