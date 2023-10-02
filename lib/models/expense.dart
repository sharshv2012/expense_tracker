import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart'; // imported for terminal for unique ID's
import 'package:intl/intl.dart'; // imported for terminal for Date Formatting and localization.

const uuid = Uuid(); // for generating unique ID's
final formatter = DateFormat.yMd(); // for formatting date passed to this object.

enum Category {leisure, food, work, travel }

const categoryIcons = { // A map, categories as keys
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work,
};
class Expense {

  Expense({required this.title, required this.amount,
   required this.date, required this.category }): id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate { // created a getter for formatting date. getter is used when we have to mutate any variable or element of the same class we are in.
    return formatter.format(date);
  }
}