import 'package:blood_sugar_monitor/screens/about_screen.dart';
import 'package:blood_sugar_monitor/screens/bloodsugar_entry_screen.dart';
import 'package:blood_sugar_monitor/screens/excercise_screen.dart';
import 'package:blood_sugar_monitor/screens/food_screen.dart';
import 'package:blood_sugar_monitor/screens/history_screen.dart';
import 'package:blood_sugar_monitor/screens/home_screen.dart';
import 'package:blood_sugar_monitor/screens/medication_screen.dart';
import 'package:flutter/material.dart';
import 'package:blood_sugar_monitor/screens/login_screen.dart';
import 'package:blood_sugar_monitor/screens/registration_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blood Sugar App',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), //,const LoginScreen(),
      routes: {
        LoginScreen.route: (context) => const LoginScreen(),
        RegistrationScreen.route: (context) => const RegistrationScreen(),
        HomeScreen.route: (context) => const HomeScreen(),
        BloodSugarEntryScreen.route: (context) => const BloodSugarEntryScreen(),
        FoodScreen.route: (context) => const FoodScreen(),
        ExcerciseScreen.route: (context) => const ExcerciseScreen(),
        MedicationScreen.route: (context) => const MedicationScreen(),
        HistoryScreen.route: (context) => const HistoryScreen(),
        AboutScreen.route: (context) => const AboutScreen(),
      },
    );
  }
}
