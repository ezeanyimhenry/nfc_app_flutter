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
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     _showPermissionDialog();
  //   });
  // }

  // void _showPermissionDialog() {
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         contentPadding: XPadding.horizontal16,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             YGap(value: MediaQuery.sizeOf(context).height * 0.041),
  //             Text(
  //               'To provide the best experience,\nwe need to access certain features on your device.',
  //               textAlign: TextAlign.center,
  //               style: GoogleFonts.inter(
  //                 textStyle: const TextStyle(
  //                   fontWeight: FontWeight.w500,
  //                   fontSize: 18.0,
  //                   color: AppColors.primaryTextColor,
  //                 ),
  //               ),
  //             ),
  //             const YGap(value: 20),
  //             Column(
  //               // crossAxisAlignment: CrossAxisAlignment.start,
  //               children: [
  //                 Row(
  //                   children: [
  //                     //  const Icon(Icons.nfc),
  //                     const XGap(value: 10),
  //                     Expanded(
  //                       child: Text(
  //                         'NFC Access\nRequired to scan NFC tags',
  //                         style: AppTextStyle.bodyText,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const YGap(value: 10),
  //                 Row(
  //                   children: [
  //                     // const Icon(Icons.wifi),
  //                     const XGap(value: 10),
  //                     Expanded(
  //                       child: Text(
  //                         'Internet Access\nNeeded for real-time translation',
  //                         style: AppTextStyle.bodyText,
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 20.0),
  //             PrimaryButton(
  //               onTap: () {
  //                 Navigator.of(context).pop();
  //               },
  //               text: 'Allow',
  //             ),
  //             YGap(value: MediaQuery.sizeOf(context).height * 0.02),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  // Future<void> showSequentialBottomSheets(BuildContext context) async {
  //   final myProvider = Provider.of<NFCNotifier>(context, listen: false);

  //   // Function to show a bottom sheet and wait for it to close
  //   Future<void> showBottomSheetAndWait({
  //     required Widget bottomSheet,
  //     bool autoDismiss = true,
  //   }) async {
  //     final Completer<void> completer = Completer<void>();

  //     showModalBottomSheet(
  //       context: context,
  //       isDismissible: !autoDismiss,
  //       enableDrag: autoDismiss,
  //       builder: (context) {
  //         if (autoDismiss) {
  //           Timer(const Duration(seconds: 3), () {
  //             // Close the bottom modal sheet if autoDismiss is true
  //             Navigator.pop(context);
  //           });
  //         }
  //         return bottomSheet;
  //       },
  //     ).whenComplete(() {
  //       completer.complete();
  //     });

  //     return completer.future;
  //   }

  //   // Show the first bottom sheet
  //   await showBottomSheetAndWait(
  //     bottomSheet: SizedBox(
  //       height: MediaQuery.of(context).size.height * 0.4,
  //       child: AppBottomsheet(
  //         message:
  //             "Please place the back of your device near the tag receiver to read tag.",
  //         title: "Ready to Scan",
  //         centerContent: SvgPicture.asset('assets/icons/svg/ready_to_scan.svg'),
  //       ),
  //     ),
  //   );
  //   // Wait for the bottom sheet to close before showing the next one
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   // Show the second bottom sheet
  //   await showBottomSheetAndWait(
  //     bottomSheet: const SizedBox(
  //       // height: MediaQuery.of(context).size.height * 0.4,
  //       child: AppBottomsheet(
  //         message: "Make sure your device is well placed.",
  //         title: "Scanning...",
  //         centerContent: ProgressIndicatorWithText(
  //           progress: 0.75,
  //         ),
  //       ),
  //     ),
  //   );
  //   // Wait for the bottom sheet to close before showing the next one
  //   await Future.delayed(const Duration(milliseconds: 300));

  //   // Show the third bottom sheet
  //   await showBottomSheetAndWait(
  //     bottomSheet: SizedBox(
  //       // height: MediaQuery.of(context).size.height * 0.4,
  //       child: AppBottomsheet(
  //         hasPrimaryButton: true,
  //         primaryButtonText: "Continue",
  //         primaryButtonOnTap: () {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) =>
  //                   TranslateScreen(message: myProvider.message),
  //             ),
  //           );
  //         },
  //         message: "Scan Successful!",
  //         title: "Scan Successful!",
  //         centerContent: const ProgressIndicatorWithText(
  //           progress: 1.0,
  //         ),
  //       ),
  //     ),
  //     autoDismiss: false,
  //   );
  // }
  bool nfcEnabled = true;
  @override
  void initState() {

    super.initState();
    NfcManager.instance.isAvailable().then((c) {
      setState(() {
        nfcEnabled = c;
      });
    });
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
                  visible: nfcEnabled,
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
                const YGap(),
                Text(
                  nfcEnabled
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
                      _showSuccessBottomSheet(context, provider.message);
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

  void _showSuccessBottomSheet(BuildContext context, String message) {
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
                  builder: (context) => TranslateScreen(message: message),
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
