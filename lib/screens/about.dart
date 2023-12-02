import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 149, 138, 138),
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 149, 138, 138),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'WalletTrack',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 65,
            ),
            Text(
              'About This app ',
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              'WalletTrack is a financial tracking application that helps users manage their personal finances effectively.With CashFlow users can track income, expenses, and savings, and gain valuable insights into their spending habits and financial goals. The app provides a user-friendly interface and powerful features to assist users in budgeting, setting financial targets, and monitoring their progress over time. It also offers visualizations and reports to visualize financial data, enabling users to make informed decisions about their money. strives to empower individuals in achieving their financial objectives and promoting financial wellness.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
