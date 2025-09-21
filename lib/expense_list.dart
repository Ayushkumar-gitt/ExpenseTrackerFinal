import 'package:expense_tracker_2/expense_Item.dart';
import 'package:expense_tracker_2/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses});
  final List<ExpenseModel> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (cntx, index) => ExpenseItem(expense: expenses[index]),
    );
  }
}
