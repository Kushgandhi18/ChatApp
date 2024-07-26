import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mychatapp/screens/loginpage.dart';
import 'package:mychatapp/screens/splash_screen.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/myprovider.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );




  runApp(

    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MyProvider()),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen()
    );
  }
}