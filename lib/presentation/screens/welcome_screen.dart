import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/home.dart';
import 'package:nfc_app/presentation/screens/watch_demo_screen.dart';

import 'history/logic/sharedPreference.dart';
import 'history/models/history_model.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Future<void> _addHistory() async {
    List<HistoryModel> loadedHistoryList =
        await AppSharedPreference().getHistoryList();

    HistoryModel newHistory = HistoryModel(
      language: 'English',
      date: DateTime.now(),
      actualText: 'Sample text',
      type: HistoryType.Read,
    );
    setState(() {
      loadedHistoryList.add(newHistory);
    });
    print(loadedHistoryList);
    await AppSharedPreference().saveHistoryList(loadedHistoryList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/svg/welcomescreen_icon.svg'),
              const YGap(),
              Text(
                'Welcome to Translate Buddy',
                style: AppTextStyle.welcomeScreenHeading,
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // _addHistory();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (txt) => const HomeScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Use App',
                    style: AppTextStyle.primaryButtonText,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (txt) => const WatchDemoScreen(),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: const BorderSide(
                          width: 1, color: AppColors.primaryColor)),
                  child: Text(
                    'Watch Demo',
                    style: AppTextStyle.secondaryButtonText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
