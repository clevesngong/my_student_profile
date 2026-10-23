import 'package:flutter/material.dart';

class StudentProfile extends StatelessWidget {
  const StudentProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Student -Profile'),
      ),
      body: const Center(
        child: Text('My Student Profile'),
      ),
    );
  }
}