import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
//import 'package:contacts_buddy/splash_screen.dart';
import 'package:flutter/services.dart';
//import 'package:new_contact_buddy/SaveDetails.dart';
import 'firebase_options.dart';
import 'package:new_contact_buddy/MainMenu.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
  );

  // Run your app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MainMenu(),
    );
  }
}
