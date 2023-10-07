import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Color.fromARGB(255, 210, 249, 194),
      
        ),

      home: Expenses(),
    ),
  );
}