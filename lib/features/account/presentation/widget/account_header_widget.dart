import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';

class AccountHeaderWidget extends StatelessWidget {

  const AccountHeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        bottom: 20,
        top: 50,
      ),
      color: AppPallete.backgroundColor,
      alignment: Alignment.center,
      child: Text(
        'Akun Saya',
        style: GoogleFonts.kantumruyPro(
          fontSize: 25,
          fontWeight: FontWeight.w500,
          color: AppPallete.darkBackgroundColor,
        ),
      ),
    );
  }
}