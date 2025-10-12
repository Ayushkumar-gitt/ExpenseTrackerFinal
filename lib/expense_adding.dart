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
  Category selectedCategory = Category.leisure;
  void openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  void submitExpensesData() {
    final enteredAmount = double.tryParse(amount.toString());
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (isAmountInvalid || selectedDate == null || title.trim().isEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Invalid Input"),
          content: Text("Please Enter data correctly"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text("Okay"),
            ),
          ],
        ),
      );
    }
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
          SizedBox(height: 20),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toString().toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    selectedCategory = value;
                  });
                },
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  submitExpensesData();
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
