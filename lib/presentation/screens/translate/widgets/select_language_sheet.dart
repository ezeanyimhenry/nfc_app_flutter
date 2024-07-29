import 'package:flutter/material.dart';
import 'package:nfc_app/presentation/screens/translate/translate_screen.dart';
class SelectTargetLanguageSheet extends StatelessWidget {
  const SelectTargetLanguageSheet({
    super.key,
  });

  final languages = const [
    "Yoruba",
    "Tiv",
    "Pidgin",
    "Hausa",
    "Igbo",
    "Idoma",
    "Igala",
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(languages.length, (index) {
        return InkWell(
          onTap: () => Navigator.pop(context, languages[index]),
          child: Column(
            children: [
              Text(languages[index]),
              Visibility(
                visible: index != languages.length - 1,
                child: const Divider(color: dividerColor),
              )
            ],
          ),
        );
      }),
    );
  }
}
