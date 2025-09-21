import 'package:expense_tracker_2/expense_list.dart';
import 'package:expense_tracker_2/expense_model.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<ExpenseModel> registeredExpenses = [
    ExpenseModel(
      title: "Office",
      amount: 10.20,
      date: DateTime.now(),
      category: Category.work,
    ),
    ExpenseModel(
      title: "Movie",
      amount: 20.32,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  void openModelSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Text("Temp  data");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [IconButton(onPressed: openModelSheet, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [Expanded(child: ExpenseList(expenses: registeredExpenses))],
      ),
    );
  }
}
