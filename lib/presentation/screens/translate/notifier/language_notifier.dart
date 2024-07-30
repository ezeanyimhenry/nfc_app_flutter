import 'package:flutter/material.dart';
import 'package:nfc_app/models/languages.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_dto.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_response.dart';
import 'package:nfc_app/presentation/screens/translate/repository/translate_repository.dart';

class LanguageNotifier extends ChangeNotifier {
  LanguageNotifier(this.translateRepository);
  final TranslateRepository translateRepository;

  bool isTranslating = false;
  TranslateAndDetectResponse translateResponse =
      TranslateAndDetectResponse.initial();
  
  /// This is the default language (initial state)
  /// It would be the language the user selects in settings
  String languageToBeTranslatedTo = "English";

  void setTargetLanguage(String language) {
    languageToBeTranslatedTo = language;
    notifyListeners();
  }

  void updateTranslatingTo(bool state) {
    isTranslating = state;
    notifyListeners();
  }

  List<String> searchResult = [];
  final allLanguages = Languages().languages;

  void filterLanguage(String input) {
    searchResult = allLanguages
        .where(
            (language) => language.toLowerCase().contains(input.toLowerCase()))
        .toList();

    notifyListeners();
  }

  void translateMessage(TranslateDTO dto) async {
    updateTranslatingTo(true);
    translateResponse = await translateRepository.translateMessage(dto);
    updateTranslatingTo(false);
  }
}
