import 'package:flutter/material.dart';
import 'package:labor_managment/constants/colors.dart';
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
      initialRoute: '/userRegistration',
      routes: {
        '/workerRegistration': (context) => WorkerRegistration(),
        '/workerLogin': (context) => WorkerLogin(),
        '/workerHome': (context) => WorkerHome(),
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
