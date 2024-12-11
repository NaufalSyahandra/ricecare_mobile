import 'package:flutter/material.dart';
import 'package:ricecare_mobile/core/theme/app_pallete.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ricecare_mobile/features/history/presentation/pages/history_page.dart';
import 'package:ricecare_mobile/features/home/presentation/pages/home_page.dart';
import 'package:ricecare_mobile/features/account/presentation/pages/account_page.dart';
import 'package:ricecare_mobile/features/scan/presentation/page/scan_page.dart';

class NavbarWidget extends StatefulWidget {
  final int initialIndex;

  const NavbarWidget({super.key, this.initialIndex = 0});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HistoryPage(),
        ),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ScanPage(),
        ),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AccountPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: AppPallete.secondaryTextColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10,
              offset: Offset(0, -6),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppPallete.backgroundColor,
          selectedItemColor: AppPallete.grayColor,
          unselectedItemColor: AppPallete.grayColor,
          showUnselectedLabels: true,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppPallete.grayColor,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppPallete.grayColor,
          ),
          items: [
            _buildNavItem(
              icon: Icons.home,
              label: 'Home',
              index: 0,
            ),
            _buildNavItem(
              icon: Icons.history,
              label: 'History',
              index: 1,
            ),
            _buildFloatingScanItem(),
            _buildNavItem(
              icon: Icons.star,
              label: 'Fitur',
              index: 3,
            ),
            _buildNavItem(
              icon: Icons.account_circle,
              label: 'Profile', // Label untuk profile
              index: 4,
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildFloatingScanItem() {
    return BottomNavigationBarItem(
      icon: GestureDetector(
        onTap: () => _onItemTapped(2),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _selectedIndex == 2 ? 75 : 65,
          height: _selectedIndex == 2 ? 75 : 65,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: _selectedIndex == 2
                  ? AppPallete.buttonColor
                  : Colors.transparent,
              width: 3,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            Icons.qr_code_scanner,
            size: _selectedIndex == 2 ? 45 : 35,
            color: _selectedIndex == 2
                ? AppPallete.buttonColor
                : AppPallete.grayColor,
          ),
        ),
      ),
      label: '',
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: _selectedIndex == index ? 30 : 28,
            color: _selectedIndex == index
                ? AppPallete.buttonColor
                : AppPallete.grayColor,
          ),
          if (_selectedIndex == index)
            Container(
              margin: const EdgeInsets.only(top: 2),
              height: 3,
              width: 20,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppPallete.buttonColor,
                    AppPallete.buttonHighlightColor
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
        ],
      ),
      label: label,
    );
  }
}
