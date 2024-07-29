import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:provider/provider.dart';

import '../../notifier/bottom_nav.dart';

class AppBottomNav extends StatelessWidget {
  final int selectedindex;
  const AppBottomNav({super.key, required this.selectedindex});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, provider, child) {
      return BottomNavigationBar(
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.setIndex(index);
        },
        selectedLabelStyle: AppTextStyle.smallBodyTextActive,
        unselectedLabelStyle: AppTextStyle.smallBodyTextInactive,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset((selectedindex == 0)
                ? 'assets/svg/icons/read_nfc_active.svg'
                : 'assets/svg/icons/read_nfc_inactive.svg'),
            label: 'Read NFC',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset((selectedindex == 1)
                ? 'assets/svg/icons/history_active.svg'
                : 'assets/svg/icons/history_inactive.svg'),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset((selectedindex == 2)
                ? 'assets/svg/icons/settings_active.svg'
                : 'assets/svg/icons/settings_inactive.svg'),
            label: 'Settings',
          ),
        ],
      );
    });
  }
}
