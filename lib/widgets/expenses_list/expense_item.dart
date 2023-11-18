import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget{
  const ExpenseItem({super.key, required this.record});

  final Map<dynamic, dynamic> record;

  @override
  Widget build(BuildContext context) {

    String amount = record['amount'];
    String date = record['date'].toString().substring(0, 10);
    double convertedAmount = double.parse(amount);
    
    
    return Card(child: Padding(
      padding: const EdgeInsets.symmetric( // for different paddings.
        horizontal: 24,
        vertical: 18,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            record['title'],
            style: Theme.of(context).textTheme.titleLarge, //using the 
            //predefined theme for titles from main in this widget.
            
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text("₹ ${convertedAmount.toStringAsFixed(2)}"),//  12.3345 => 12.33
              const Spacer(),// all the space it can get between widgets.
              Row(
                children: [
                  Icon(categoryIcons[record['category'].toString()]),
                  const SizedBox(width: 8),
                  Text(date)// we are using a getter that's why unlike a function it isn't takking value i.e. expense.date .
                ],
              )
            ],
          )
        ],
      ),
    ),);
  }
}