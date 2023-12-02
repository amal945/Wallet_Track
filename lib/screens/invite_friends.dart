// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 149, 138, 138),
      appBar: AppBar(
        title: Text(
          'Invite Friends',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: const Color.fromARGB(255, 149, 138, 138),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invite Friends',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'WalletTrack encourages users to invite friends to use the app and experience its benefits. By inviting friends, you agree to the following terms and guidelines:',
            ),
            SizedBox(height: 16.0),
            _buildTermsList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTermsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTermItem('1. Eligibility', [
          'You must be a current user of WalletTrack to invite friends to use the app.',
          'The invitee must be a new user to WalletTrack and must not have an existing account.',
        ]),
        _buildTermItem('2. Invitation Process', [
          'To invite friends, you may use the designated invite functionality within the app.',
          'You may invite friends via email, SMS, or any other means provided by the app.',
        ]),
        _buildTermItem('3. Representations and Warranties', [
          'You represent and warrant that you have the necessary permissions to invite friends and that your invitations comply with applicable laws and regulations.',
          'You will not use the invitation feature to spam, harass, or engage in any form of unethical behavior.',
        ]),
        _buildTermItem('4. Rewards', [
          'WalletTrack may offer rewards or incentives for successful friend invitations. The nature and specifics of these rewards will be determined by WalletTrack and are subject to change at any time.',
        ]),
        _buildTermItem('5. Responsibility', [
          'You are responsible for ensuring that your friends consent to receive invitations and for any consequences resulting from your invitations.',
        ]),
        _buildTermItem('6. Compliance', [
          'Invitations and usage of this feature must comply with these Terms and Conditions, our Privacy Policy, and any applicable laws.',
        ]),
        _buildTermItem('7. Modification and Termination', [
          'WalletTrack reserves the right to modify, suspend, or terminate the invite friends feature at any time without prior notice.',
        ]),
      ],
    );
  }

  Widget _buildTermItem(String title, List<String> points) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: points
              .map((point) => Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Text('• $point'),
                  ))
              .toList(),
        ),
        SizedBox(height: 16.0),
      ],
    );
  }
}
