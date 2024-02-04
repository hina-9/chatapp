  
  // class {
    
  // }
  
  
  // Widget ChatRoomsList() {
  //   return StreamBuilder(
  //       stream: chatRoomStream,
  //       builder: (ctx, AsyncSnapshot snapshot) {
  //         return snapshot.hasData
  //             ? ListView.builder(
  //                 padding: EdgeInsets.zero,
  //                 itemCount: snapshot.data.docs.length,
  //                 shrinkWrap: true,
  //                 itemBuilder: (ctx, index) {
  //                   //docs.....................
  //                   DocumentSnapshot ds = snapshot.data.docs[index];
  //                   return ChatRoomListTile(
  //                       chatRoomId: ds.id,
  //                       lastMsg: ds['lastMessage'],
  //                       myUsername: myUsername!,
  //                       time: ds['lastMessageSendTs']);
  //                 })
  //             : Center(
  //                 child: CircularProgressIndicator(),
  //               );
  //       });
  // }