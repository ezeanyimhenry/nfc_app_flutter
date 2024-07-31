import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/presentation/screens/write-nfc/add_record_screen.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

class WriteNFCScreen extends StatelessWidget {
  const WriteNFCScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor2,
        leading: Padding(
          // fpadding: const EdgeInsets.only(left: 16.0),
          padding: XPadding.horizontal16,
          // child: Text(
          //   'Write NFC Tag',
          //   style: GoogleFonts.inter(
          //     color: AppColors.primaryTextColor,
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Write NFC Tag',
                style: GoogleFonts.inter(
                  color: AppColors.primaryTextColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: double.infinity,
      ),
      body: Padding(
        padding: XPadding.horizontal24,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/phone_center_image.png'),
            const YGap(),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: PrimaryButton(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (txt) => const AddRecordScreen(),
                  ),
                ),
                text: 'Write NFC Tag',
              ),
            ),
            const YGap(),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Text(
                    'Tap on the ‘+’ button to add new records.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const YGap(value: 24.0),
                  Text(
                    'Or ‘Write NFC Tag’ to detect NFC tag for writing.',
                    style: GoogleFonts.inter(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
