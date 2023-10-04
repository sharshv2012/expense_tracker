import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  @override
  void dispose() {
    // we'll have to delete the textEditingController after modal is not in use to free the memory.
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // var _enteredTitle = ''; // this method might not be good as we can have many textfields so we'll have to make many variables that's why we'll use controllers.
  // void _saveTitleInput(String inputValue){ // for this you don't need to setState as UI isn't changing.
  //   _enteredTitle = inputValue;
  // }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50, //setting max string length
            decoration: const InputDecoration(
              label: Text("Title"),
              border: OutlineInputBorder(),
            ),
          ),
          TextField(
            controller: _amountController,
            maxLength: 10, //setting max string length
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              prefixText: "₹ ",
              label: Text("Expense"),
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            children: [
              TextButton(onPressed: () {
                Navigator.pop(context);
              }, child: Text("CANCEL")),
              ElevatedButton(
                onPressed: () {
                  print(_titleController.text);
                },
                child: const Text("SAVE"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
