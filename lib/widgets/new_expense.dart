import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('dd/MM/yyyy');// for formatting date
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
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day); // previous possible date
    final lastDate = now;

    final pickedDate = await showDatePicker(
      context: context, 
      initialDate: now, 
      firstDate: firstDate, 
      lastDate: lastDate
    );
    setState(() {
      _selectedDate = pickedDate;
    });
    
  }

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
          Row(
            children: [
              Expanded( //Same rendering issue can arise having TextField inside of a row that's why used Expanded.
                child: TextField(
                  controller: _amountController,
                  maxLength: 10, //setting max string length
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "₹ ",
                    label: Text("Expense"),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(// we are having a row inside of a row which can cause rendering problem that's why we are using Expanded.
                  mainAxisAlignment: MainAxisAlignment.end, // pushing icon and text to the end
                  crossAxisAlignment: CrossAxisAlignment.center, // for centering the item vertically
                  children: [
                    Text(_selectedDate == null ? "No Date Selected" : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month)
                    ),
                  ],
                ) 
                )
            ],
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
