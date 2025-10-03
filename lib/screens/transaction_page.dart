import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:wallet_track/db/transaction_data_model.dart';
import 'package:wallet_track/functions/db_transaction_functions.dart';
import 'package:wallet_track/screens/edit_transaction_page.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
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

  bool isSortButtonSelected = false;
  DateTime? fromDate;
  DateTime? toDate;
  bool isIncomeSelected = false;
  bool isExpenseSelected = false;

  void _showDateFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              color: const Color.fromARGB(255, 32, 30, 30),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 32, 30, 30),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 12),
                      child: Text(
                        "Select Range",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "From:",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          color: const Color.fromARGB(
                                              255, 141, 132, 132),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Done",
                                                      style: TextStyle(
                                                          color: Colors.yellow),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 200,
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  initialDateTime: fromDate ??
                                                      DateTime.now().subtract(
                                                          const Duration(
                                                              days: 7)),
                                                  maximumYear:
                                                      DateTime.now().year,
                                                  onDateTimeChanged: (date) {
                                                    setState(() {
                                                      fromDate = date;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(fromDate ?? DateTime.now()),
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "To:",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          color: const Color.fromARGB(
                                              255, 141, 132, 132),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      "Done",
                                                      style: TextStyle(
                                                          color: Colors.yellow),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 200,
                                                child: CupertinoDatePicker(
                                                  mode: CupertinoDatePickerMode
                                                      .date,
                                                  initialDateTime:
                                                      toDate ?? DateTime.now(),
                                                  maximumYear:
                                                      DateTime.now().year,
                                                  onDateTimeChanged: (date) {
                                                    setState(() {
                                                      toDate = date;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                DateFormat('dd-MM-yyyy')
                                    .format(toDate ?? DateTime.now()),
                                style: const TextStyle(
                                  color: Colors.yellow,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Divider(),
                    Wrap(
                      spacing: 10,
                      children: <Widget>[
                        ChoiceChip(
                          label: const Text("Income"),
                          selected: isIncomeSelected,
                          selectedColor: Colors.yellow,
                          onSelected: (selected) {
                            setState(() {
                              isIncomeSelected = selected;
                            });
                          },
                        ),
                        ChoiceChip(
                          label: const Text("Expense"),
                          selected: isExpenseSelected,
                          selectedColor: Colors.yellow,
                          onSelected: (selected) {
                            setState(() {
                              isExpenseSelected = selected;
                            });
                          },
                        ),
                        ChoiceChip(
                          label: const Text("Both"),
                          selected: !isIncomeSelected && !isExpenseSelected,
                          selectedColor: Colors.yellow,
                          onSelected: (selected) {
                            setState(() {
                              isIncomeSelected = !selected;
                              isExpenseSelected = !selected;
                            });
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      children: [
                        const SizedBox(
                          width: 120,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color.fromARGB(255, 239, 191, 19)),
                          ),
                          onPressed: () {
                            filterTransactions();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Apply",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void filterTransactions() {
    final List<TransactionModel> originalData = transactionListNotifier.value;
    final List<TransactionModel> filteredData = [];

    for (final TransactionModel data in originalData) {
      final bool isIncome = data.category == "Income";
      final bool isExpense = data.category == "Expense";

      final bool isWithinDateRange = (fromDate == null ||
          toDate == null ||
          (data.date.isAfter(fromDate!) && data.date.isBefore(toDate!)));

      if ((isIncomeSelected && isIncome) ||
          (isExpenseSelected && isExpense) ||
          (!isIncomeSelected && !isExpenseSelected)) {
        if (isWithinDateRange) {
          filteredData.add(data);
        }
      }
    }

    transactionListNotifier.value = filteredData;
  }

  void clearFilter() {
    fromDate = null;
    toDate = null;
    isIncomeSelected = false;
    isExpenseSelected = false;
    filterTransactions();
  }

  String searchQuery = '';

  void onSearchQueryChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  List<TransactionModel> getFilteredTransactions() {
    if (searchQuery.isEmpty) {
      return transactionListNotifier.value;
    } else {
      return transactionListNotifier.value.where((transaction) {
        return transaction.categoryType
                .toLowerCase()
                .contains(searchQuery.toLowerCase()) ||
            transaction.amount.toString().contains(searchQuery) ||
            transaction.note.toString().contains(searchQuery);
      }).toList();
    }
  }

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    getAllTransactions();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 32, 30, 30),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: !isSearching
              ? const Text("All transactions")
              : TextField(
                  style: const TextStyle(color: Colors.white),
                  onChanged: onSearchQueryChanged,
                  decoration: const InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                ),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    onSearchQueryChanged('');
                  }
                });
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  isSortButtonSelected = !isSortButtonSelected;
                  if (isSortButtonSelected) {
                    _showDateFilterBottomSheet();
                  } else {
                    clearFilter();
                  }
                });
              },
              icon: Icon(
                Icons.sort,
                color: isSortButtonSelected ? Colors.yellow : Colors.white,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: ValueListenableBuilder(
              valueListenable: transactionListNotifier,
              builder: (context, transactions, child) {
                final filteredTransactions = getFilteredTransactions();
                final reversedTransactions =
                    filteredTransactions.reversed.toList();

                if (reversedTransactions.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(
                        top: screenHeight * 0.3, left: screenWidth * 0.2),
                    child: const Text(
                      "No data added",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (ctx, index) {
                    final data = reversedTransactions[index];
                    final categoryIcon =
                        categoryIcons[data.categoryType] ?? Icons.category;
                    Color containerColor = data.category == "Expense"
                        ? const Color.fromARGB(255, 253, 187, 45)
                        : Colors.green;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Slidable(
                        endActionPane: ActionPane(
                            motion: const StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: ((context) {
                                  deleteTransaction(data.id);
                                }),
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                              )
                            ]),
                        child: Container(
                          color: containerColor,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditTransactionPage(
                                      transactionData: data),
                                ),
                              );
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    const Color.fromARGB(255, 32, 30, 30),
                                radius: 24,
                                child: Icon(
                                  categoryIcon,
                                  color: iconsColor[categoryIcon],
                                  size: 35,
                                ),
                              ),
                              title: Text(
                                data.amount.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 23,
                                ),
                              ),
                              subtitle: Text(
                                data.categoryType.toString(),
                                style: const TextStyle(color: Colors.white),
                              ),
                              trailing: Text(
                                DateFormat('dd MMMM y').format(data.date),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (ctx, index) {
                    return const Divider(
                      color: Color.fromARGB(255, 32, 30, 30),
                      height: 15,
                    );
                  },
                  itemCount: reversedTransactions.length,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
