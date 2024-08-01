import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/notifier/nfc_notifier.dart';
import 'package:nfc_app/presentation/screens/history/models/history_model.dart';
import 'package:nfc_app/presentation/screens/translate/text_found_screen.dart';
import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_sheet.dart';
import 'package:nfc_app/presentation/widgets/app_buttons.dart';
import 'package:nfc_app/presentation/widgets/circle_progress_indicator.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:provider/provider.dart';

import '../history/logic/shared_preference.dart';

class TextRecordScreen extends StatefulWidget {
  const TextRecordScreen({super.key});

  @override
  State<TextRecordScreen> createState() => _TextRecordScreenState();
}

class _TextRecordScreenState extends State<TextRecordScreen> {
  final controller = TextEditingController();
  bool _nfcEnabled = false;

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

  writeToNfc() {
    Provider.of<NFCNotifier>(context, listen: false).startNFCOperation(
        nfcOperation: NFCOperation.write,
        context: context,
        content: controller.text);
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NFCNotifier(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: AppColors.backgroundColor2,
          title: Text(
            'Write To NFC Tag',
            style: AppTextStyle.alertDialogHeading,
          ),
        ),
        body: SingleChildScrollView(
          padding: AllPadding.padding16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'Type or paste the text you want to store on the NFC Tag and select ‘’Write Data’’ below.',
                    style: AppTextStyle.bodyText,
                  ),
                  const YGap(value: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: controller,
                          maxLines: null,
                          minLines: 10,
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelText: 'Enter text here',
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            constraints: BoxConstraints(
                              maxHeight: 300,
                            ),
                            contentPadding: EdgeInsets.all(12.0),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Divider(
                          color: AppColors.dividerColour,
                          thickness: 1,
                        ),
                        SizedBox(height: 8.0),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: IconButton(
                            icon:
                                SvgPicture.asset('assets/icons/svg/paste.svg'),
                            onPressed: () async {
                              final clipboardData =
                                  await Clipboard.getData('text/plain');
                              if (clipboardData != null) {
                                controller.text = clipboardData.text ?? '';
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const YGap(value: 70.0),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: PrimaryButton(
                      onTap: () async {
                        if (_nfcEnabled) {
                          writeToNfc();
                          //save to history
                          List<HistoryModel> loadedHistoryList =
                              await AppSharedPreference().getHistoryList();
                          loadedHistoryList.add(HistoryModel(
                              label: LanguageType.target,
                              language: "English",
                              date: DateTime.now(),
                              actualText: controller.text,
                              type: HistoryType.written));
                          await AppSharedPreference()
                              .saveHistoryList(loadedHistoryList);
                        } else {
                          showModalBottomSheet(
                              isDismissible: false,
                              context: context,
                              builder: (context) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  child: AppBottomsheet(
                                    message:
                                        "Failed to write data to the NFC tag. Please try again.",
                                    title: "Write Operation Failed",
                                    centerContent: SvgPicture.asset(
                                        'assets/icons/svg/nfc_unavailable.svg'),
                                    hasPrimaryButton: true,
                                    primaryButtonText: 'Try Again',
                                    primaryButtonOnTap: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                );
                              });
                        }
                      },
                      text: 'Write Data'),
                ),
              ),
              Consumer<NFCNotifier>(builder: (context, provider, _) {
                if (provider.isProcessing) {
                  // return const CircularProgressIndicator();
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
                      });
                }
                if (provider.message.isNotEmpty) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pop(context);
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
                                    builder: (txt) => TextFoundScreen(
                                        foundText: provider.readContent),
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
                        });
                  });
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
