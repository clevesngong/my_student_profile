
import 'package:flutter/material.dart';
import 'package:profile/student_profile.dart';


void main() {
  runApp(const MyStudentProfileApp());
}

class MyStudentProfileApp extends StatelessWidget {
  const MyStudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Student Profile',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const StudentProfile(),
    );
  }
}
