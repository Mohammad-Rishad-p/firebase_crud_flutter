import 'package:blood_firebase/pages/home_page.dart';
import 'package:blood_firebase/projec1/add_donor.dart';
import 'package:blood_firebase/projec1/update_donor.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context) =>HomePage(),
        '/add':(context) => AddDonor(),
        '/update':(context) => UpdateDonor(),
      },
    );
  }
}



