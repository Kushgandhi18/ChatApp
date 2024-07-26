import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../models/myprovider.dart';
import '../models/myusermodel.dart';
import 'loginpage.dart';
import 'myuserlist.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> checkLogin() async {
    if (FirebaseAuth.instance.currentUser == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => LoginPage()));
    } else {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("myusers")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<dynamic, dynamic> data = snapshot.data() as Map;

      MyUserModel model = MyUserModel(
          name: data["name"],
          email: data["email"],
          imgurl: data["imgurl"],
          status: data["status"],
          uid: FirebaseAuth.instance.currentUser!.uid);

      Provider.of<MyProvider>(context, listen: false)
          .setUserModel(model, isRefresh: false);

      print("old user");

      Navigator.push(
          context, MaterialPageRoute(builder: (ctx) => MyUserList()));
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2), () {
      checkLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _mainBody();
  }

  Widget _mainBody() {
    return SafeArea(
        child: Scaffold(
          body: Center(
            child: SpinKitCircle(
              color: Colors.blue,
              size: 50,
            ),
          ),
        ));
  }
}
