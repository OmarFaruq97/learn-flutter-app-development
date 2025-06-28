import 'package:api_call/main.dart';
import 'package:api_call/screens/employee_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EmployeeCrud());
}

class EmployeeCrud extends StatelessWidget {
  const EmployeeCrud({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee CRUD App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const EmployeeScreen(),
    );
  }
}
