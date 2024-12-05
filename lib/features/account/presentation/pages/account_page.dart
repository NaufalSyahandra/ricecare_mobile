import 'package:flutter/material.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/account_container_widget.dart';
import 'package:ricecare_mobile/features/account/presentation/widget/account_header_widget.dart';
import 'package:ricecare_mobile/features/home/presentation/widget/navbar_widget.dart'; // Import the Navbar

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            AccountHeaderWidget(),
            AccountContainerWidget(),
          ],
        ),
      ),
      bottomNavigationBar: NavbarWidget(initialIndex: 4), // Use the Navbar widget
    );
  }
}