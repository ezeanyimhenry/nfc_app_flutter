import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_textstyles.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedindex;
  const AppBottomNav({super.key, required this.selectedindex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: AppTextStyle.smallBodyTextActive,
      unselectedLabelStyle: AppTextStyle.smallBodyTextInactive,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset((selectedindex == 0)
              ? 'assets/icons/svg/read_nfc_active.svg'
              : 'assets/icons/svg/read_nfc_inactive.svg'),
          label: 'Read NFC',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset((selectedindex == 1)
              ? 'assets/icons/svg/history_active.svg'
              : 'assets/icons/svg/history_inactive.svg'),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset((selectedindex == 2)
              ? 'assets/icons/svg/settings_active.svg'
              : 'assets/icons/svg/settings_inactive.svg'),
          label: 'Settings',
        ),
      ],
    );
  }
}
