import 'package:flutter/material.dart';

class AccountLoadingWidget extends StatelessWidget {
  const AccountLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blueAccent,
      ),
    );
  }
}
