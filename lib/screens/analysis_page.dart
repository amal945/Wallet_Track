// ignore_for_file: unnecessary_const, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:wallet_track/db/transaction_data_model.dart';
import 'package:wallet_track/functions/db_transaction_functions.dart';
import 'package:wallet_track/widgets/chart.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({super.key});

  @override
  State<AnalysisPage> createState() => _AnalysisPageState();
}

ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

class _AnalysisPageState extends State<AnalysisPage> {
  List day = ['Day', 'Week', 'Month', 'Year'];
  List f = [today(), Week(), month(), year()];
  final List<String> months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  String getMonthInWords(int month) {
    // Ensure the month is within a valid range (1-12)
    if (month < 1 || month > 12) {
      return 'Invalid month';
    }
    return months[month - 1]; // Adjust for 0-based indexing in lists
  }

  List<TransactionModel> a = [];

  @override
  Widget build(BuildContext context) {
    getAllTransactions();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 32, 30, 30),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: transactionListNotifier,
          builder: (BuildContext context, dynamic value, Widget? child) {
            a = f[selectedIndexNotifier.value];
            return custom();
          },
        ),
      ),
    );
  }

  CustomScrollView custom() {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Statistics',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(
                      4,
                      (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndexNotifier.value = index;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: selectedIndexNotifier.value == index
                                  ? const Color.fromARGB(255, 236, 199, 31)
                                  : Colors.white,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              day[index],
                              style: TextStyle(
                                color: selectedIndexNotifier.value == index
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Chart(
                data: a,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
