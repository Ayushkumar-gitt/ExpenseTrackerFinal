import 'package:expense_tracker_2/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseAdding extends StatefulWidget {
  const ExpenseAdding({super.key});

  @override
  State<ExpenseAdding> createState() => _ExpenseAddingState();
}

class _ExpenseAddingState extends State<ExpenseAdding> {
  String title = "";
  double amount = 0;
  DateTime? selectedDate;
  void openDatePicker() async {
    final now = DateTime.now();
    final FirstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: FirstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
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
                  Text(
                    selectedDate == null
                        ? "No Selected Date"
                        : formater.format(selectedDate!),
                  ),
                  SizedBox(width: 16),
                  IconButton(
                    onPressed: openDatePicker,
                    icon: Icon(Icons.calendar_month),
                  ),
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
