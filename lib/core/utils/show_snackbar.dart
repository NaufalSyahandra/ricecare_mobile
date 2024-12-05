import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(0),
        elevation: 10,
        // Bayangan untuk kesan elegan
        backgroundColor: Colors.transparent,
        // Latar belakang transparan
        duration: const Duration(seconds: 5),
        content: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purpleAccent.shade200,
                Colors.deepPurple.shade600,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              const Icon(
                Icons.check_circle_outlined,
                color: Colors.yellowAccent,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ),
    );
}
