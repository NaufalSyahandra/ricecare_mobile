import 'package:flutter/material.dart';

class HomeLoadings extends StatelessWidget {
  const HomeLoadings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
