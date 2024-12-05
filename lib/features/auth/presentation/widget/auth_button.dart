import 'package:flutter/material.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppPallete.buttonColor,
            AppPallete.buttonHighlightColor,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(500, 55),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          text,
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppPallete.backgroundColor),
        ),
      ),
    );
  }
}
