import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(title: 'Flutter Course', amount: 500, date: DateTime.now(), category: Category.work),
    Expense(title: 'Dining', amount: 300, date: DateTime.now(), category: Category.food),
    Expense(title: 'Movie', amount: 200, date: DateTime.now(), category: Category.leisure),
  ];
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Text("the chart"),
          ,
        ],
      ),
    );
  }
}
