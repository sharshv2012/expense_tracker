import 'package:uuid/uuid.dart';

const uuid = Uuid(); // for generating unique ID's
class Expense {

  Expense({required this.title, required this.amount,
   required this.date }): id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
}