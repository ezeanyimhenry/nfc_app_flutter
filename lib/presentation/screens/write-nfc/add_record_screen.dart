import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/presentation/screens/write-nfc/text_record_screen.dart';

class AddRecordScreen extends StatelessWidget {
  const AddRecordScreen({super.key});

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
          'Add a record',
          style: GoogleFonts.inter(
            color: AppColors.primaryTextColor,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (txt) => const TextRecordScreen(),
            ),
          ),
          child: Container(
            padding: AllPadding.padding8,
            width: double.infinity,
            height: 53.0,
            decoration: const BoxDecoration(
              border: Border(
                  left: BorderSide.none,
                  top: BorderSide(color: Color(0xFFF2F2F7)),
                  right: BorderSide.none,
                  bottom: BorderSide.none),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                        'assets/icons/svg/add_text_record_icon.svg'),
                    const XGap(value: 8.0),
                    Text(
                      'Add text record',
                      style: GoogleFonts.inter(
                        color: AppColors.primaryTextColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (txt) => const TextRecordScreen(),
                    ),
                  ),
                  icon: SvgPicture.asset('assets/chevron_right.svg'),
                ),
                // SvgPicture.asset('assets/chevron_right.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class RecordTile extends StatelessWidget {
//   const RecordTile({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.red,
//       width: double.infinity,
//     );
//   }
// }
