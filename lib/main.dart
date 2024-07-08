import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';
import 'package:labor_managment/dash_board.dart';
import 'package:labor_managment/user/user_login.dart';
import 'package:labor_managment/user/user_registration.dart';
import 'package:labor_managment/worker/worker_home.dart';
import 'package:labor_managment/worker/worker_login.dart';
import 'package:labor_managment/worker/worker_registration.dart';

void main() {
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
<<<<<<< HEAD
      initialRoute: '/userRegistration',
=======

      initialRoute: '/workerRegistration',
>>>>>>> b1d7e2e76214bf0dbf77f1db3096030a71b2a9fd
      routes: {
        '/workerRegistration': (context) => WorkerRegistration(),
        '/workerLogin': (context) => WorkerLogin(),
        '/workerHome': (context) => WorkerHome(),
        '/userLogin': (context) => UserLogin(),
        '/dashBoard': (context) => DashBoard(),
        '/userRegistration': (context) => UserRegistration(),
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
