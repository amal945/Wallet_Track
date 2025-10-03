// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wallet_track/db/transaction_data_model.dart';
import 'package:wallet_track/functions/db_transaction_functions.dart';
import 'package:wallet_track/screens/dashboard.dart';

class EditTransactionPage extends StatefulWidget {
  final TransactionModel transactionData;
  const EditTransactionPage({super.key, required this.transactionData});

  @override
  State<EditTransactionPage> createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  late DateTime selectedDate;
  late String selectedCategory;
  late String selectedCategoryType;
  late bool isExpense;
  bool isEditMode = false;
  @override
  void initState() {
    super.initState();
    amountController.text = widget.transactionData.amount.toString();
    noteController.text = widget.transactionData.note;
    selectedDate = widget.transactionData.date;
    selectedCategory = widget.transactionData.category.toString();
    selectedCategoryType = widget.transactionData.categoryType.toString();
    if (selectedCategory == "Expense") {
      isExpense = true;
    } else {
      isExpense = false;
    }

    isEditMode = false;
  }

  final Map<IconData, Color> iconsColor = {
    Icons.fastfood: Colors.yellow,
    Icons.shopping_cart: Colors.lightBlue,
    Icons.route: Colors.purple,
    Icons.gamepad: Colors.lightGreen,
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
    "Entertainment": Icons.gamepad,
    "Medical": Icons.health_and_safety,
    "Education": Icons.school,
    "Fitness": Icons.directions_run,
    "Rent": Icons.attach_money,
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
    CategoryData("Entertainment", Icons.gamepad),
    CategoryData("Medical", Icons.health_and_safety),
    CategoryData("Education", Icons.school),
    CategoryData("Fitness", Icons.fitness_center),
    CategoryData("Rent", Icons.home),
    CategoryData("Other", Icons.more_horiz),
  ];

  void _onChipSelected(bool selected, String category) {
    if (isEditMode) {
      setState(() {
        isExpense = selected;
        selectedCategory = category;
      });
    }
  }

  void _showCategoryBottomSheet(BuildContext context) {
    if (isEditMode) {
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
                        leading: Icon(category.icon,
                            color: iconsColor[category.icon]),
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
  }

  void _selectDate(BuildContext context) {
    if (isEditMode) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Transaction"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 76, 106, 141),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                setState(() {
                  isEditMode = !isEditMode;
                });
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
                onPressed: () {
                  if (widget.transactionData.id == null) {
                    // print("No id Available");
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          backgroundColor:
                              const Color.fromARGB(255, 52, 48, 48),
                          title: const Text(
                            "Do you really want to delete...?",
                            style: TextStyle(color: Colors.white),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                "Cancel",
                                style: TextStyle(color: Colors.yellow),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteTransaction(widget.transactionData.id);
                                // deleteTransaction(widget.transactionData.id!);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Home()),
                                    (route) => false);
                              },
                              child: const Text(
                                "Delete",
                                style: TextStyle(color: Colors.yellow),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: Container(
          color: const Color.fromARGB(255, 32, 30, 30),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
                          bottomLeft: Radius.circular(3),
                        ),
                      ),
                      label: const Text("    Income    "),
                      selected: isExpense,
                      selectedColor: Colors.grey,
                      disabledColor: const Color.fromARGB(255, 170, 163, 163),
                      onSelected: (selected) =>
                          _onChipSelected(selected, "Income"),
                    ),
                    ChoiceChip(
                      shape: const BeveledRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(3),
                          bottomRight: Radius.circular(3),
                        ),
                      ),
                      label: const Text("    Expense    "),
                      selected: !isExpense,
                      selectedColor: Colors.grey,
                      disabledColor: const Color.fromARGB(255, 170, 163, 163),
                      onSelected: (selected) =>
                          _onChipSelected(!selected, "Expense"),
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
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.white, fontSize: 23),
                    enabled: isEditMode,
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
                  padding: const EdgeInsets.only(left: 16.0),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.grey),
                    controller: noteController,
                    enabled: isEditMode,
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
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Icon(categoryIcons[selectedCategoryType],
                            size: 35,
                            color: iconsColor[
                                categoryIcons[selectedCategoryType]]),
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
        floatingActionButton: isEditMode
            ? FloatingActionButton(
                backgroundColor: Colors.yellow,
                onPressed: () {
                  // print(widget.transactionData.id);
                  updateTransactionDetails();
                  // print("Update Button Clicked");
                  Navigator.pop(context);
                  const snackdemo = SnackBar(
                    content: Text('Updated succesfully'),
                    backgroundColor: Colors.green,
                    elevation: 5,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.all(3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackdemo);
                },
                child: const Icon(
                  Icons.save,
                  color: Colors.black,
                ),
              )
            : null);
  }

  Future<void> updateTransactionDetails() async {
    final int amount = int.parse(amountController.text);
    final String note = noteController.text;
    final String category = selectedCategory;
    final String categoryType = selectedCategoryType;
    final DateTime updatedDate = selectedDate;

    final updatedTransaction = TransactionModel(
      id: widget.transactionData.id.toString(),
      amount: amount,
      date: updatedDate,
      note: note,
      category: category,
      categoryType: categoryType,
    );

    await updateTransaction(updatedTransaction);
  }
}

class CategoryData {
  final String name;
  final IconData icon;

  CategoryData(this.name, this.icon);
}
