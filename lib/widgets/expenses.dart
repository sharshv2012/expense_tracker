import 'dart:math';

import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
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

  void _openExpenseOverlay(){
    showModalBottomSheet(context: context, 
     // isScrollControlled: true, for allocating it fullScreen
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical( // for providing corner radius to the modal.
        top: Radius.circular(25.0),
      ),
    ),
    builder: (context) => NewExpense(onAddExpense: _addExpense,) , 
    );
  }
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
    
  }
  void _removeExpense(Expense expense){
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Expense Deleted"),
        action: SnackBarAction(
          label: 'Undo'
        , onPressed: () {
          setState(() {
            _registeredExpenses.insert(expenseIndex, expense);
          });
        }
        ),
        ),);
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = const Center(child: Text("No Expense Found. Start Adding Some!"),);
    if(_registeredExpenses.isNotEmpty){
      mainContent = ExpensesList( // you can do this if you want to define a widget away from main tree.
          expenses: _registeredExpenses,
          onRemoveExpense: _removeExpense,
      );
    }
    return  Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.cyanAccent,
        title: const Text("Get Your Expenses In Track"),
        actions: [
          IconButton(onPressed: _openExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text("the chart"),
          Expanded( // is you have a list inside a list or column use epanded.
            child: mainContent,
            )
        ],
      ),
    );
  }
}
