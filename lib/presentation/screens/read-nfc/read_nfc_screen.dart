import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
// import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/notifier/nfc_notifier.dart';
import 'package:nfc_app/presentation/screens/translate/translate_screen.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_sheet.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:nfc_app/presentation/widgets/circle_progress_indicator.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

class ReadNFCScreen extends StatefulWidget {
  const ReadNFCScreen({super.key});

  @override
  State<ReadNFCScreen> createState() => _ReadNFCScreenState();
}

class _ReadNFCScreenState extends State<ReadNFCScreen> {
  bool _nfcEnabled = true;
  @override
  void initState() {
    super.initState();
    _checkNFCAvailability();
  }

  Future<void> _checkNFCAvailability() async {
    bool isAvailable = await NfcManager.instance.isAvailable();
    if (mounted) {
      setState(() {
        _nfcEnabled = isAvailable;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NFCNotifier(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor2,
          leading: Padding(
            padding: XPadding.horizontal16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Read NFC',
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
        body: Center(
          child: Padding(
            padding: XPadding.horizontal24,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/phone_center_image.png'),
                const YGap(),
                Visibility(
                  visible: _nfcEnabled,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: PrimaryButton(
                      onTap: () {
                        Provider.of<NFCNotifier>(context, listen: false)
                            .startNFCOperation(
                          nfcOperation: NFCOperation.read,
                          context: context,
                        );
                        _showInitialBottomSheet(context);
                      },
                      text: 'Scan NFC tag',
                    ),
                  ),
                ),
                Visibility(
                  visible: !_nfcEnabled,
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.6,
                    child: InactiveButton(
                      onTap: () {},
                      text: 'Scan NFC tag',
                    ),
                  ),
                ),
                const YGap(),
                Text(
                  _nfcEnabled
                      ? 'Please place the top of your device near the tag receiver'
                      : "Your device is not nfc enabled, therefore can't use the app",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodyText,
                ),
                Consumer<NFCNotifier>(builder: (context, provider, _) {
                  if (provider.isProcessing) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _showProcessingBottomSheet(context);
                    });
                  }
                  if (provider.readContent.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context); // Close the previous bottom sheet
                      _showSuccessBottomSheet(context, provider.readContent);
                    });
                  }
                  return const SizedBox();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showInitialBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: AppBottomsheet(
            hasInactiveButton: true,
            inactiveButtonText: "Continue",
            inactiveButtonOnTap: () {},
            message:
                "Please place the back of your device near the tag receiver to read tag.",
            title: "Ready to Scan",
            centerContent:
                SvgPicture.asset('assets/icons/svg/ready_to_scan.svg'),
          ),
        );
      },
    );
  }

  void _showProcessingBottomSheet(BuildContext context) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: const AppBottomsheet(
            message: "Make sure your device is well placed.",
            title: "Scanning...",
            centerContent: ProgressIndicatorWithText(
              progress: 0.75,
            ),
          ),
        );
      },
    );
  }

  void _showSuccessBottomSheet(BuildContext context, String readContent) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: AppBottomsheet(
            hasPrimaryButton: true,
            primaryButtonText: "Continue",
            primaryButtonOnTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TranslateScreen(message: readContent),
                ),
              );
            },
            message: "Make sure your device is well placed.",
            title: "Scan Successful!",
            centerContent: const ProgressIndicatorWithText(
              progress: 1.0,
            ),
          ),
        );
      },
    );
  }
}
