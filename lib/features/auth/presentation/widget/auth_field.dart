import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String labelText;
  final bool isObscure;
  final TextEditingController controller;

  const AuthField({
    super.key,
    required this.labelText,
    this.isObscure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      obscureText: isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return "$labelText is missing";
        }
        return null;
      },
    );
  }
}
