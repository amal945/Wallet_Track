// ignore_for_file: library_private_types_in_public_api, unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_track/db/transaction_data_model.dart';
import 'package:wallet_track/functions/db_transaction_functions.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({Key? key});

  @override
  _AddTransactionPageState createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  String selectedCategory = "Expense";

  String selectedCategoryType = "Other";
  bool isExpense = true;
  DateTime selectedDate = DateTime.now();

  final Map<IconData, Color> iconsColor = {
    Icons.fastfood: Colors.yellow,
    Icons.shopping_cart: Colors.lightBlue,
    Icons.route: Colors.purple,
    Icons.sports_esports: Colors.lightGreen,
    Icons.health_and_safety: Colors.red,
    Icons.school: Colors.purpleAccent,
    Icons.fitness_center: Colors.orange,
    Icons.home: const Color.fromARGB(255, 37, 99, 39),
    Icons.more_horiz: const Color.fromARGB(255, 139, 199, 249),
    Icons.redeem: Colors.purple,
    Icons.money: const Color.fromARGB(255, 245, 235, 152),
  };

  final Map<String, IconData> categoryIcons = {
    "Food": Icons.fastfood,
    "Shopping": Icons.shopping_cart,
    "Travel": Icons.route,
    "Entertainment": Icons.sports_esports,
    "Medical": Icons.health_and_safety,
    "Education": Icons.school,
    "Fitness": Icons.fitness_center,
    "Rent": Icons.home,
    "Other": Icons.more_horiz,
    "Coupons": Icons.redeem,
    "Sold Items": Icons.shopping_cart,
    "Salary": Icons.money,
  };

  List<CategoryData> incomeCategories = [
    CategoryData("Salary", Icons.money),
    CategoryData("Sold Items", Icons.shopping_cart),
    CategoryData("Coupons", Icons.redeem),
    CategoryData("Other", Icons.more_horiz),
  ];

  List<CategoryData> expenseCategories = [
    CategoryData("Food", Icons.fastfood),
    CategoryData("Shopping", Icons.shopping_cart),
    CategoryData("Travel", Icons.route),
    CategoryData("Entertainment", Icons.sports_esports),
    CategoryData("Medical", Icons.health_and_safety),
    CategoryData("Education", Icons.school),
    CategoryData("Fitness", Icons.fitness_center),
    CategoryData("Rent", Icons.home),
    CategoryData("Other", Icons.more_horiz),
  ];

  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  void _showCategoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 15.0, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Select a Category",
                      style: TextStyle(color: Colors.yellow, fontSize: 25),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: isExpense
                      ? expenseCategories.length
                      : incomeCategories.length,
                  itemBuilder: (context, index) {
                    final category = isExpense
                        ? expenseCategories[index]
                        : incomeCategories[index];
                    return ListTile(
                      leading:
                          Icon(category.icon, color: iconsColor[category.icon]),
                      title: Text(
                        category.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        setState(() {
                          selectedCategoryType = category.name;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _selectDate(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Colors.yellow),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    ).then((value) {
      if (value != null) {
        final dateWithoutTime = DateTime(value.year, value.month, value.day);
        setState(() {
          selectedDate = dateWithoutTime;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Transaction"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 76, 106, 141),
      ),
      body: Container(
        color: const Color.fromARGB(255, 32, 30, 30),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(3),
                            bottomLeft: Radius.circular(3))),
                    label: const Text("    Income    "),
                    selected: isExpense,
                    selectedColor: Colors.grey,
                    disabledColor: const Color.fromARGB(255, 170, 163, 163),
                    onSelected: (selected) {
                      setState(() {
                        isExpense = selected;
                        selectedCategory = "Income";
                      });
                    },
                  ),
                  ChoiceChip(
                    shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(3),
                            bottomRight: Radius.circular(3))),
                    label: const Text("    Expense    "),
                    selected: !isExpense,
                    selectedColor: Colors.grey,
                    disabledColor: const Color.fromARGB(255, 170, 163, 163),
                    onSelected: (selected) {
                      setState(() {
                        isExpense = !selected;
                        selectedCategory = "Expense";
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _selectDate(context);
                    },
                    icon: const Icon(
                      Icons.calendar_month,
                      size: 35,
                      color: Color.fromARGB(
                        255,
                        76,
                        106,
                        141,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    DateFormat('dd MMMM y').format(selectedDate),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.1),
                child: TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white, fontSize: 23),
                  decoration: const InputDecoration(
                    labelText: "Amount",
                    hintText: "0",
                    hintStyle: TextStyle(fontSize: 25, color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.grey),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: screenWidth * 0.1),
                child: TextFormField(
                  style: const TextStyle(color: Colors.grey),
                  controller: noteController,
                  decoration: const InputDecoration(
                    hintText: "Write a note",
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                child: Padding(
                  padding: EdgeInsets.only(left: screenWidth * 0.02),
                  child: Row(
                    children: [
                      Icon(categoryIcons[selectedCategoryType],
                          size: 35,
                          color:
                              iconsColor[categoryIcons[selectedCategoryType]]),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Categories",
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            selectedCategoryType,
                            style: const TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                onTap: () {
                  _showCategoryBottomSheet(context);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: () {
          onAddButtonClicked(context);
        },
        child: const Icon(
          Icons.save,
          color: Colors.black,
        ),
      ),
    );
  }

  void onAddButtonClicked(BuildContext context) {
    final amount = amountController.text.trim();
    final note = noteController.text.trim();
    final category = selectedCategory;
    final categoryType = selectedCategoryType;
    final date = selectedDate;

    if (amount.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Text("Enter the amount"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } else {
      final amountValue = int.parse(amount);
      final transaction = TransactionModel(
          amount: amountValue,
          note: note,
          category: category,
          categoryType: categoryType,
          date: date);
      addTransaction(transaction);
      setState(() {
        // This block will trigger a rebuild
      });
      const snackdemo = SnackBar(
        content: Text('Added successfully'),
        backgroundColor: Colors.green,
        elevation: 5,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(3),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      Navigator.pop(context);
    }
  }
}

class CategoryData {
  final String name;
  final IconData icon;

  CategoryData(this.name, this.icon);
}
