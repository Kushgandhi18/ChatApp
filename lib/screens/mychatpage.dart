import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mychatapp/models/myusermodel.dart';
import 'package:provider/provider.dart';

import '../models/myprovider.dart';
class MyChatPage extends StatefulWidget {
  final MyUserModel userModel;

  const MyChatPage({required this.userModel});

  @override
  State<MyChatPage> createState() => _MyChatPageState();
}

class _MyChatPageState extends State<MyChatPage> {
  TextEditingController txtmsg = TextEditingController();

  ScrollController controller = ScrollController();

  late MyProvider provider;

  String laststatus = "online";

  String chatId = "";
  late FirebaseFirestore firestore;
  List<Map<String, dynamic>> mylist = [];

  Future<String> getChatId() async {
    String otherUserId = widget.userModel.uid;
    String myUsrtId = FirebaseAuth.instance.currentUser!.uid;

    String AB = myUsrtId + otherUserId;
    String BA = otherUserId + myUsrtId;

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection("personalChats")
        .doc(AB)
        .get();

    if (snapshot.exists) {
      return AB;
    } else {
      DocumentSnapshot snapshot1 = await FirebaseFirestore.instance
          .collection("personalChats")
          .doc(BA)
          .get();

      if (snapshot1.exists) {
        return BA;
      } else {
        return AB;
      }
    }
  }

  Future<void> getMsg()async {


    chatId=await getChatId();


    firestore
        .collection("personalChats").doc(chatId).collection("msgs")
        .orderBy("createdAt")
        .snapshots(includeMetadataChanges: true)
        .listen((data) {
      mylist.clear();
      for (int i = 0; i < data.docs.length; i++) {
        QueryDocumentSnapshot d = data.docs[i];
        Map<String, dynamic> mydata = d.data() as Map<String, dynamic>;
        mylist.add(mydata);
      }

      controller.jumpTo(controller.position.maxScrollExtent);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    firestore = FirebaseFirestore.instance;
    Future.delayed(Duration(milliseconds: 500), () {
      getMsg();
    });

  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<MyProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: _mainBody(),
      ),
    );
  }

  Widget _mainBody() {
    return Column(
      children: [_appBar(), _msgBody(), _chatInput()],
    );
  }

  Widget _msgBody() {
    return Expanded(
        child: ListView.builder(
            controller: controller,
            itemCount: mylist.length,
            itemBuilder: (ctx, index) {
              return myItem(mylist[index]);
            }));
  }

  Widget _chatInput() {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          height: 1,
          color: Colors.grey,
        ),
        Container(
          padding: EdgeInsets.only(bottom: 20, left: 15, right: 15, top: 10),
          child: Row(
            children: [
              Expanded(
                  child: TextField(
                    onChanged: (val) {},
                    controller: txtmsg,
                  )),
              InkWell(
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 50,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.blueGrey),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget myItem(Map<String, dynamic> map) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: map['sender']==Constants.userid?Colors.blue:Colors.grey,
      ),
      child: Row(
        mainAxisAlignment: map['sender'] != provider.usermodel!.uid
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (map['sender'] != provider.usermodel!.uid)
            Container(
                margin: EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                child: ClipOval(child: Image.network(map["senderImage"]))),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: map['sender'] == provider.usermodel!.uid
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                map["senderName"],
                style: TextStyle(fontSize: 15),
              ),
              Text(
                map["msg"],
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          if (map['sender'] == provider.usermodel!.uid)
            Container(
                margin: EdgeInsets.only(left: 10),
                width: 30,
                height: 30,
                child:
                ClipOval(child: Image.network(provider.usermodel!.imgurl)))
        ],
      ),
    );
  }

  Widget _appBar() {
    return Container(
        padding: EdgeInsets.all(10),
        color: Colors.black87,
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                )),
            SizedBox(
              width: 15,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.white),
              height: 45,
              width: 45,
              padding: EdgeInsets.all(1),
              child: ClipOval(
                child: Image.network(
                  widget.userModel.imgurl,
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userModel.name,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                // Text(provider.usermodel!.status,
                //     style: TextStyle(fontSize: 16, color: Colors.white))
              ],
            ),
          ],
        ));
  }

}
