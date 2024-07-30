import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/notifier/nfc_notifier.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_sheet.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:nfc_app/presentation/widgets/circle_progress_indicator.dart';
import 'package:provider/provider.dart';

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
                  const YGap(value: 10),
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

  void _showMyBottomSheet(BuildContext context) {
    // Access the provider instance
    final myProvider = Provider.of<NFCNotifier>(context, listen: false);

    // Show the bottom sheet
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AppBottomsheet(
          message: "",
          title: "Successful.",
          centerContent: PrimaryButton(
            onTap: () {},
            text: myProvider.message,
          ), // Pass provider message here
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NFCNotifier(),
      child: Scaffold(
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
                    onTap: () {
                      Provider.of<NFCNotifier>(context, listen: false)
                          .startNFCOperation(nfcOperation: NFCOperation.read);
                      // showModalBottomSheet(
                      //     isDismissible: false,
                      //     context: context,
                      //     builder: (context) {
                      //       return SizedBox(
                      //         height: MediaQuery.of(context).size.height * 0.4,
                      //         child: AppBottomsheet(
                      //           message:
                      //               "Please place the back of your device near the tag receiver to read tag.",
                      //           title: "Ready to Scan",
                      //           centerContent: SvgPicture.asset(
                      //               'assets/icons/svg/ready_to_scan.svg'),
                      //         ),
                      //       );
                      //     });

                      showModalBottomSheet(
                          isDismissible: false,
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: const AppBottomsheet(
                                message:
                                    "Make sure your device is well placed.",
                                title: "Scanning...",
                                centerContent: ProgressIndicatorWithText(
                                  progress: 0.75,
                                ),
                              ),
                            );
                          });
                    },
                    text: 'Scan NFC tag',
                  ),
                ),
                const YGap(),
                const Text(
                  'Please place the top of your device near the tag receiver',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0),
                ),
                Consumer<NFCNotifier>(builder: (context, provider, _) {
                  if (provider.isProcessing) {
                    // return const CircularProgressIndicator();
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return const AppBottomsheet(
                            message: "Make sure your device is well placed.",
                            title: "Scanning...",
                            centerContent: ProgressIndicatorWithText(
                              progress: 0.75,
                            ),
                          );
                        });
                  }
                  if (provider.message.isNotEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.pop(context);
                      // showResultDialog(context, provider.message);
                      _showMyBottomSheet(context);
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: const Text('Result'),
                      //       content: Text(provider.message),
                      //       actions: [
                      //         ElevatedButton(
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //           child: const Text('OK'),
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
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
}
