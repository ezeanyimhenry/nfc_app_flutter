import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';

class TextRecordScreen extends StatelessWidget {
  const TextRecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor2,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: SvgPicture.asset(
            'assets/arrow_left.svg',
            fit: BoxFit.scaleDown,
          ),
        ),
        title: Text(
          'Text Record',
          style: GoogleFonts.inter(
            color: AppColors.primaryTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: AllPadding.padding16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'Enter Text Record',
                  style: GoogleFonts.inter(
                    color: AppColors.primaryTextColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const YGap(value: 16.0),
                const SizedBox(
                  height: 121.0,
                  child: TextField(
                    maxLines: 4, // Allow up to 3 lines of text
                    // minLines: 4, // Ensure at least one line is visible
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Enter text here',
                      // labelStyle: ,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.primaryColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      constraints: BoxConstraints(
                        maxHeight: 121,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const YGap(value: 16.0),
            PrimaryButton(onTap: () {
              
            }, text: 'Add')
          ],
        ),
      ),
    );
  }
}
