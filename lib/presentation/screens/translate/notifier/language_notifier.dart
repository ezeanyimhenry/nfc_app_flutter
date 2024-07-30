import 'package:flutter/material.dart';
import 'package:nfc_app/models/languages.dart';

class LanguageNotifier extends ChangeNotifier {
  List<String> searchResult = [];
  final allLanguages = Languages().languages;

  void filterLanguage(String input) {
    searchResult = allLanguages
        .where(
            (language) => language.toLowerCase().contains(input.toLowerCase()))
        .toList();

    notifyListeners();
  }
}
