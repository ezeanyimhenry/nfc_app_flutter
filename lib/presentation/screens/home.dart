import 'package:flutter/material.dart';
import 'package:nfc_app/presentation/screens/history_screen.dart';
import 'package:nfc_app/presentation/screens/settings_screen.dart';
import 'package:nfc_app/presentation/screens/write_nfc_screen.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_nav.dart';
import 'package:provider/provider.dart';

import '../../notifier/bottom_nav.dart';
import 'read_nfc_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  final List<Widget> _screens = const [
    ReadNFCScreen(),
    WriteNFCScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<BottomNavigationProvider>(
      builder: (context, provider, child) {
        return _screens[provider.currentIndex];
      },
    ), bottomNavigationBar:
        Consumer<BottomNavigationProvider>(builder: (context, provider, child) {
      return AppBottomNav(selectedindex: provider.currentIndex);
    }));
  }
}
