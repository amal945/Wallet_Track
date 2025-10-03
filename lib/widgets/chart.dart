// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:wallet_track/db/transaction_data_model.dart';
import 'package:wallet_track/functions/db_transaction_functions.dart';

import 'package:pie_chart/pie_chart.dart';
import 'package:wallet_track/db/transaction_data_model.dart';

class Chart extends StatefulWidget {
  final List<TransactionModel> data;

  const Chart({super.key, required this.data});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    getAllTransactions();

// Calculate total income and expenses
    int totalIncome = total_chart(
        widget.data.where((item) => item.category == 'Income').toList());
    int totalExpenses = total_chart(
        widget.data.where((item) => item.category == 'Expense').toList());

    // print('Total Income: $totalIncome, Total Expenses: $totalExpenses');

// Calculate percentages
    double expensesPercentage =
        totalIncome != 0 ? (totalExpenses / totalIncome) * 100 : 0;
    double incomePercentage =
        totalExpenses != 0 ? (totalIncome / totalExpenses) * 100 : 0;

    // print(
    //     'Income Percentage: $incomePercentage, Expenses Percentage: $expensesPercentage');

    incomePercentage = incomePercentage.clamp(0, 100);
    expensesPercentage = expensesPercentage.clamp(0, 100);

    if (totalIncome == 0) {
      incomePercentage = 0;
      expensesPercentage = 100;
    } else if (totalExpenses == 0) {
      incomePercentage = 100;
      expensesPercentage = 0;
    }

    // print(
    //     'Income Percentage: $incomePercentage, Expenses Percentage: $expensesPercentage');

// Data for the pie chart
    Map<String, double> dataMap = {
      'Income': incomePercentage.abs(),
      'Expense': expensesPercentage.abs(),
    };

    // Colors for the pie chart sections
    List<Color> colorList = [Colors.green, Colors.red];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: PieChart(
            dataMap: dataMap,
            colorList: colorList,
            animationDuration: Duration(milliseconds: 800),
            chartRadius: MediaQuery.of(context).size.width / 2.7,
            chartLegendSpacing: 32,
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.bottom,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
              decimalPlaces: 2,
            ),
          ),
        ),
        SizedBox(height: 16),
        // Display the legend with percentages
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegend(
              Colors.green,
              "Income (${incomePercentage.toStringAsFixed(2)}%)",
              incomePercentage,
              'Income',
              Colors.white, // Set the desired text color for income
            ),
            const SizedBox(width: 16),
            _buildLegend(
              Colors.red,
              "Expense (${expensesPercentage.toStringAsFixed(2)}%)",
              expensesPercentage,
              "Expense",
              Colors.red, // Set the desired text color for expense
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegend(
      Color color, String label, double per, String category, Color textColor) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          color: color,
        ),
        SizedBox(width: 8),
        Text(
          per.isInfinite ? "$category " : label,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500), // Set the text color here
        ),
      ],
    );
  }
}
