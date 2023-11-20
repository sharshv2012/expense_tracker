import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.records, required this.onRemoveExpense});
  final List<dynamic>? records;
  final void Function(int index, String id) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    // you shold not use column or listView without builder for 
    //lists where we don't know it's length and we might have many data items
    // just like recyclerView in android native.
    return records == null ?  Text("Nothing to show here : (" ) : ListView.builder(
      itemCount: records!.length,
      itemBuilder: (ctx, index) => Dismissible(// wrap the widget for dissmissible property.
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75), // a variation of colors are set for different aspects by default.
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ), 
        ),
        key: ValueKey(records![index]),
        onDismissed: (direction) { // we need to give a direction in case we 
        //have different functionality for swiping from different directions.
          onRemoveExpense( index,records![index]['_id']);
        },
        child: ExpenseItem(record: records![index]),
      ), // for deleting the list item by swiping
    );
  }
}
