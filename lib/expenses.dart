import 'package:expense_tracker_2/chart.dart';
import 'package:expense_tracker_2/expense_adding.dart';
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
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return ExpenseAdding(onAddExpense: addExpense);
      },
    );
  }

  void addExpense(ExpenseModel expense) {
    setState(() {
      registeredExpenses.add(expense);
    });
  }

  void removeExpense(ExpenseModel expense) {
    int index = registeredExpenses.indexOf(expense);
    setState(() {
      registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Expense Deleted"),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              registeredExpenses.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent = Center(
      child: Text(
        "No Expense Found , Please enter some",
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
    );

    if (registeredExpenses.isNotEmpty) {
      maincontent = ExpenseList(
        expenses: registeredExpenses,
        onRemoveExpense: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker"),
        actions: [IconButton(onPressed: openModelSheet, icon: Icon(Icons.add))],
      ),
      body: Column(
        children: [
          Chart(expenses: registeredExpenses),
          Expanded(child: maincontent),
        ],
      ),
    );
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  final Category category;
  final List<ExpenseModel> expenses;

  ExpenseBucket.forCategory(List<ExpenseModel> allexpense, this.category)
    : expenses = allexpense
          .where((expense) => expense.category == category)
          .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
