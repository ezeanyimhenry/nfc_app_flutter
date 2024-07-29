import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
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
        showUnselectedLabels: true,
        currentIndex: provider.currentIndex,
        onTap: (index) {
          provider.setIndex(index);
        },
        selectedLabelStyle: AppTextStyle.smallBodyTextActive,
        unselectedLabelStyle: AppTextStyle.smallBodyTextInactive,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.secondaryTextColor,
        items: [
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset('assets/icons/svg/read_nfc_active.svg'),
            icon: SvgPicture.asset('assets/icons/svg/read_nfc_inactive.svg'),
            label: 'Read NFC',
          ),
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset('assets/icons/svg/write_nfc_active.svg'),
            icon: SvgPicture.asset('assets/icons/svg/write_nfc_inactive.svg'),
            label: 'Write Tag',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset('assets/icons/svg/history_active.svg'),
            icon: SvgPicture.asset('assets/icons/svg/history_inactive.svg'),
            label: 'History',
          ),
          BottomNavigationBarItem(
            activeIcon:
                SvgPicture.asset('assets/icons/svg/settings_active.svg'),
            icon: SvgPicture.asset('assets/icons/svg/settings_inactive.svg'),
            label: 'Settings',
          ),
        ],
      );
    });
  }
}
