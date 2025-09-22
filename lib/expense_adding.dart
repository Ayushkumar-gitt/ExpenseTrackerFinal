import 'package:flutter/material.dart';

class ExpenseAdding extends StatefulWidget {
  const ExpenseAdding({super.key});

  @override
  State<ExpenseAdding> createState() => _ExpenseAddingState();
}

class _ExpenseAddingState extends State<ExpenseAdding> {
  String title = "";
  double amount = 0;

  void openDatePicker() {
    final now = DateTime.now();
    final FirstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(context: context, firstDate: FirstDate, lastDate: now);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            onChanged: (value) {
              title = value;
            },
            decoration: InputDecoration(label: Text("Enter Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    amount = value as double;
                  },
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    label: Text("Amount"),
                    prefixText: '\$',
                  ),
                ),
              ),
              SizedBox(width: 24),
              Row(
                children: [
                  Text("Selected Date"),
                  SizedBox(width: 16),
                  IconButton(onPressed: openDatePicker, icon: Icon(Icons.calendar_month)),
                ],
              ),
            ],
          ),

          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  print(title);
                },
                child: Text("Save Expenses"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
