import 'package:expense_tracker_2/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});
  final ExpenseModel expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  expense.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text("\$ ${expense.amount}"),
              ],
            ),
            Row(
              children: [
                Icon(categoryIcons[expense.category]),
                SizedBox(width: 10),
                Text(expense.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
