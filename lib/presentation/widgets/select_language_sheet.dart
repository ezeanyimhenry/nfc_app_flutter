import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/constants/app_colors.dart';
import 'package:nfc_app/constants/app_spacing.dart';
import 'package:nfc_app/constants/app_textstyles.dart';
import 'package:nfc_app/presentation/screens/translate/notifier/language_notifier.dart';
import 'package:provider/provider.dart';

Future<String?> showLanguageSelectionSheet(
  BuildContext context,
  String currentLanguage,
) async {
  final searchController = TextEditingController();
  String selectedLanguage = currentLanguage;

  return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          final languageNotifier = context.watch<LanguageNotifier>();
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(context).bottom,
            ),
            child: Container(
              constraints: BoxConstraints.loose(Size(
                double.infinity,
                MediaQuery.sizeOf(context).height * 0.56,
              )),
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: AllPadding.padding8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              selectedLanguage,
                              style: AppTextStyle.bodyText,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: SvgPicture.asset(
                                  'assets/icons/svg/caret_up.svg'),
                            ),
                          ],
                        ),
                      ),
                      const YGap(
                        value: 12,
                      ),
                      TextFormField(
                        controller: searchController,
                        onChanged: (input) {
                          languageNotifier.filterLanguage(input);
                        },
                        decoration: InputDecoration(
                          hintText: "Search language",
                          enabledBorder: outlineBorder(),
                          focusedBorder: outlineBorder(AppColors.primaryColor),
                        ),
                      ),
                      const YGap(
                        value: 8,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFF2F2F7),
                            width: 1.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withOpacity(0.25), // Shadow color
                              offset: const Offset(0, 4), // Shadow offset
                              blurRadius: 4, // Blur radius of the shadow
                              spreadRadius: 0, // Spread radius of the shadow
                            ),
                          ],
                        ),
                        child: Visibility(
                          visible: searchController.text.isEmpty,
                          replacement: languageNotifier.searchResult.isEmpty
                              ? const Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 16.0),
                                    child: Text("Language not found"),
                                  ),
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: List.generate(
                                      languageNotifier.searchResult.length,
                                      (index) {
                                    return Container(
                                      color: const Color(0xFFF4F3F3),
                                      child: ListTile(
                                        title: Text(
                                          languageNotifier.searchResult[index],
                                          style: AppTextStyle.bodyTextSm,
                                        ),
                                        onTap: () {
                                          Navigator.pop(
                                            context,
                                            languageNotifier
                                                .searchResult[index],
                                          );
                                        },
                                      ),
                                    );
                                  }),
                                ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                languageNotifier.allLanguages.length, (index) {
                              return Container(
                                color: const Color(0xFFF4F3F3),
                                child: ListTile(
                                  title: Text(
                                    languageNotifier.allLanguages[index],
                                    style: AppTextStyle.bodyTextSm,
                                  ),
                                  onTap: () {
                                    setState(() {
                                      selectedLanguage =
                                          languageNotifier.allLanguages[index];
                                    });
                                    Navigator.pop(
                                      context,
                                      languageNotifier.allLanguages[index],
                                    );
                                  },
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                      // )
                    ]),
              ),
            ),
          );
        });
      });
}

OutlineInputBorder outlineBorder([Color? borderColor]) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: borderColor ?? AppColors.dividerColour),
    );
