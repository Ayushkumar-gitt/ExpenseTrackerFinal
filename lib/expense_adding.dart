import 'package:expense_tracker_2/expense_model.dart';
import 'package:flutter/material.dart';

class ExpenseAdding extends StatefulWidget {
  const ExpenseAdding({required this.onAddExpense, super.key});
  final void Function(ExpenseModel expense) onAddExpense;
  @override
  State<ExpenseAdding> createState() => _ExpenseAddingState();
}

class _ExpenseAddingState extends State<ExpenseAdding> {
  var title = TextEditingController();
  var amount = TextEditingController();
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
    final enteredAmount = double.tryParse(amount.text);
    final isAmountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (isAmountInvalid || selectedDate == null || title.text == null) {
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
    widget.onAddExpense(
      ExpenseModel(
        title: title.text,
        amount: enteredAmount!,
        date: selectedDate!,
        category: selectedCategory,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(16),
      child: Column(
        children: [
          TextField(
            maxLength: 50,
            controller: title,
            decoration: InputDecoration(label: Text("Enter Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amount,
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
                  Navigator.pop(context);
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
