import 'package:flutter/material.dart';
import 'app_constants.dart';
import 'screens/employee_list_page.dart';

void main() {
  runApp(EmployeeApp());
}

// Because who doesn't love managing employees at 3 AM? Coffee not included.

class EmployeeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Manager',
      theme: AppTheme.darkTheme,
      home: EmployeeListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
