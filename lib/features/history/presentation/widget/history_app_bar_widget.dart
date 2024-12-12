import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HistoryAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppPallete.buttonColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history, color: AppPallete.darkBackgroundColor),
          const SizedBox(width: 8),
          Text(
            'Riwayat Deteksi',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
