import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/dash_board.dart';
import 'package:labor_managment/user/user_home.dart';
import 'package:labor_managment/user/user_login.dart';
import 'package:labor_managment/user/user_registration.dart';
import 'package:labor_managment/worker/worker_home.dart';
import 'package:labor_managment/worker/worker_login.dart';
import 'package:labor_managment/worker/worker_registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/userRegistration',
      routes: {
        '/workerRegistration': (context) => WorkerRegistration(),
        '/workerLogin': (context) => WorkerLogin(),
        '/workerHome': (context) => WorkerHome(),
        '/userLogin': (context) => UserLogin(),
        '/dashBoard': (context) => DashBoard(),
        '/userRegistration': (context) => UserRegistration(),
        '/userHome' : (context) => UserHome()
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ash),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(backgroundColor: Colors.white),
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
    );
  }
}
