import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:expense_tracker/widgets/chart/chart.dart';
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
  // final List<Expense> _registeredExpenses = [
  //   Expense(
  //       title: 'Flutter Course',
  //       amount: 500,
  //       date: DateTime.now(),
  //       category: Category.work),
  //   Expense(
  //       title: 'Dining',
  //       amount: 300,
  //       date: DateTime.now(),
  //       category: Category.food),
  //   Expense(
  //       title: 'Movie',
  //       amount: 200,
  //       date: DateTime.now(),
  //       category: Category.leisure),
  // ];

  @override
  void initState() {
    super.initState();
    getRecords();
    print("hello");
  }

  List Records = [];

  Future getRecords() async {
    const String apiUrl = 'http://192.168.43.13:3000/getRecords';

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
    );

    var jsonResponse = jsonDecode(response.body);

    setState(() {
      Records = (jsonResponse['success']);
    });
    print("data fetched");
  }

  void _openExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: MediaQuery.of(context).size.width > 600
          ? true
          : false, //for allocating it fullScreen when in landScape
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          // for providing corner radius to the modal.
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => NewExpense(
        getRecords: getRecords,
      ),
    );
  }

  // void _addExpense(Expense expense) {
  //   setState(() {
  //     _registeredExpenses.add(expense);
  //   });
  // }
  showSnackBarG(){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Expense Deleted"),
      ),
    );
  }
  Future _removeExpense(int index, String id) async {
    
    const String apiUrl = 'http://192.168.43.13:3000/deleteRecord';
    print("helloooo");
    var reqBody = {"id": id};

    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reqBody));

    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['status']) {
      // if true
      setState(() {
        getRecords();
      });
    }

    showSnackBarG();

  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height; (no use)

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.cyanAccent,
        title: const Text("Get Your Expenses In Track"),
        actions: [
          IconButton(
              onPressed: _openExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(records: Records),
                Expanded(
                  // is you have a list inside a list or column use expanded.
                  child: ExpensesList(
                    // you can do this if you want to define a widget away from main tree.
                    records: Records,
                    onRemoveExpense: _removeExpense,
                  ),
                )
              ],
            )
          : Row(
              children: [
                Expanded(
                  //the chart widget takes as much width as
                  //possible(check chart.dart) which will cause UI problem
                  //to avoid this use expanded.
                  child: Chart(records: Records),
                ),
                Expanded(
                  // is you have a list inside a list or row use expanded.
                  child: ExpensesList(
                    // you can do this if you want to define a widget away from main tree.
                    records: Records,
                    onRemoveExpense: _removeExpense,
                  ),
                ),
              ],
            ),
    );
  }
}
