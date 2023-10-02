import 'package:uuid/uuid.dart';

const uuid = Uuid(); // for generating unique ID's

enum Category {leisure, food, work, travel }
class Expense {

  Expense({required this.title, required this.amount,
   required this.date, required this.category }): id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}