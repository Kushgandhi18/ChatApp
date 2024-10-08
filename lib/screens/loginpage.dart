import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../models/myprovider.dart';
import '../models/myusermodel.dart';
import 'myuserlist.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GoogleSignInAccount? account;
  User? user;
  bool isLogin=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: mainbody(),));
  }

  Widget mainbody(){
    return Container(
      width: double.maxFinite,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          isLogin? SpinKitCircle(
            color: Colors.amber,
            size: 50,
          ): loginBtn(),

        ],
      ),
    );
  }

  Widget loginBtn(){
    return InkWell(
      onTap: (){
        doGoogleLogin();

      },
      child: Container(
        color: Colors.blue,
        padding: EdgeInsets.all(10),
        child: Text("Login With Google",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800),),
      ),
    );
  }

  Future<void> doGoogleLogin() async {
    try {
      account = await GoogleSignIn().signIn();

      isLogin=true;
      setState(() {

      });


      if (account != null) {
        print("login successfully");
        setState(() {});
        doFirebaseLogin();
      } else {
        print("not login");
      }
    } catch (e) {
      print("Error : $e");
    }
  }


  Future<void> doFirebaseLogin()async{

    try{



      GoogleSignInAuthentication authentication=await account!.authentication;
      FirebaseAuth auth=FirebaseAuth.instance;

      AuthCredential authCredential= GoogleAuthProvider.credential(
          accessToken:authentication.accessToken,
          idToken:authentication.idToken
      );


      UserCredential? userCredential=await auth.signInWithCredential(authCredential);

      if(userCredential!=null)
      {
        isLogin=false;
        setState(() {
        });


        checkAndSaveUser(userCredential.user!);






      }

    }
    catch(e)
    {

      isLogin=true;
      setState(() {

      });

      print("Error : $e");
    }


  }


  Future<void> checkAndSaveUser(User user)async{




    DocumentSnapshot snapshot=await FirebaseFirestore.instance.collection("myusers").doc(user.uid).get();

    if(snapshot.data()==null)
    {
      print("new user");

      Map<String,dynamic> userdata=HashMap();
      userdata["name"]=user.displayName;
      userdata["imgurl"]=user.photoURL;
      userdata["email"]=user.email;
      userdata["status"]="online";
      userdata["uid"]=user.uid;
      userdata["createdAt"]=FieldValue.serverTimestamp();


      MyUserModel model=MyUserModel(name: user.displayName!, email: user.email!, imgurl: user.photoURL!, status: "online", uid: user.uid);

      Provider.of<MyProvider>(context,listen: false).setUserModel(model,isRefresh: false);

      await FirebaseFirestore.instance.collection("myusers").doc(user.uid).set(userdata);


    }
    else
    {


      Map<dynamic,dynamic> data=snapshot.data() as Map;


      MyUserModel model=MyUserModel(name: data["name"], email: data["email"], imgurl:data["imgurl"], status: data["status"], uid: user.uid);

      Provider.of<MyProvider>(context,listen: false).setUserModel(model,isRefresh: false);




      print("old user");
    }


    Navigator.push(context, MaterialPageRoute(builder: (ctx) => MyUserList()));


  }


}
