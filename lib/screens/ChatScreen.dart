import 'package:flutter/material.dart';
import 'package:flutter_chat_app/Constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStore = Firestore.instance;
FirebaseUser loggedUser;
class ChatScreen extends StatefulWidget {
  static const String id = "chat_screen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String myMesg;
  final msgController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedUser = user;
        print(loggedUser.email);
//        getMessages();
//        getMessageStream();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getMessageStream() async {
    await for (var mSnaps in _fireStore.collection("messages").snapshots()) {
      for (var docs in mSnaps.documents) {
        print(docs.data);
      }
    }
  }

  void getMessages() async {
    final documents = await _fireStore.collection("messages").getDocuments();
    for (var mData in documents.documents) {
      print(mData.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        title: Text("Chat"),
        backgroundColor: Colors.lightBlueAccent,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          MsgStreamBuilder(),
          Container(
            decoration: kMessageContainerDecoration,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: msgController,
                    onChanged: (value) {
                      myMesg = value;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: kMessageTextFieldDecoration,
                  ),
                ),
                FlatButton(
                    onPressed: () {
                      msgController.clear();
                      _fireStore
                          .collection("messages")
                          .add({"text": myMesg, "sender": loggedUser.email});
                    },
                    child: Text("Send", style: kSendButtonTextStyle)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MsgStreamBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection("messages").snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
//                print(snapshot);
          final msgs = snapshot.data.documents.reversed;
          List<MsgBubbleWidget> msgWidget = [];
          for(var message in msgs){
            final msgText = message.data["text"];
            final msgSender = message.data["sender"];

            final msgBubble = MsgBubbleWidget(msgText: msgText, msgSender: msgSender,isMe: msgSender == loggedUser.email,);
            msgWidget.add(msgBubble);
          }
          return Expanded(
            child: ListView(
              reverse: true,
              children: msgWidget,
            ),
          );
        }else{
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlue,
            ),
          );
        }

      },
    );
  }
}


class MsgBubbleWidget extends StatelessWidget {
  MsgBubbleWidget({this.msgText,this.msgSender,this.isMe});
  final String msgText;
  final String msgSender;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(msgSender,style: TextStyle(fontSize: 12),),
          ),
          Material(
            color: isMe ? Colors.lightBlueAccent : Colors.lightBlue,
              borderRadius: isMe ?  BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),) :
              BorderRadius.only(topRight: Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30),),
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                child: Text(msgText,style: TextStyle(fontSize: 15,color: Colors.white),),
              )),
        ],
      ),
    );
  }
}
