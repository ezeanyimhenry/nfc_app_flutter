import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

class ReadNFCScreen extends StatefulWidget {
  const ReadNFCScreen({super.key});

  @override
  State<ReadNFCScreen> createState() => _ReadNFCScreenState();
}

class _ReadNFCScreenState extends State<ReadNFCScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPermissionDialog();
    });
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: XPadding.horizontal16,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              YGap(value: MediaQuery.sizeOf(context).height * 0.041),
              Text(
                'To provide the best experience,\nwe need to access certain features on your device.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18.0,
                    color: AppColors.primaryTextColor,
                  ),
                ),
              ),
              const YGap(value: 20),
               Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                    //  const Icon(Icons.nfc),
                      const XGap(value: 10),
                      Expanded(
                        child: Text(
                          'NFC Access\nRequired to scan NFC tags',
                          style: AppTextStyle.bodyText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                 const  YGap(value: 10),
                  Row(
                    children: [
                      // const Icon(Icons.wifi),
                      const XGap(value: 10),
                      Expanded(
                        child: Text(
                          'Internet Access\nNeeded for real-time translation',
                          style: AppTextStyle.bodyText,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
                             ),
              const SizedBox(height: 20.0),
              PrimaryButton(
                onTap: () {
                  Navigator.of(context).pop();
                },
                text: 'Allow',
              ),
              YGap(value: MediaQuery.sizeOf(context).height * 0.02),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: XPadding.horizontal24,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/svg/hand_search_signal.svg'),
              const YGap(),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.6,
                child: PrimaryButton(
                  onTap: () {},
                  text: 'Scan NFC tag',
                ),
              ),
              const YGap(),
              const Text(
                'Please place the top of your device near the tag receiver',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
