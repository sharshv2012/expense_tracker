import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget{

  const ExpensesList({super.key, required this.expenses, });
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) { // you shold not use column or listView without builder for lists where we don't know it's length and we might have many data items just like recyclerView in android native.
    return ListView.builder(itemCount: expenses.length, itemBuilder: (ctx, index) => Text(expenses[index].title),);
  }
}