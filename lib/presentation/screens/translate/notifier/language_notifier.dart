import 'package:flutter/material.dart';
import 'package:nfc_app/models/languages.dart';
import 'package:nfc_app/presentation/screens/history/logic/shared_preference.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_dto.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_response.dart';
import 'package:nfc_app/presentation/screens/translate/repository/translate_repository.dart';

class LanguageNotifier extends ChangeNotifier {
  LanguageNotifier(this.translateRepository);
  final TranslateRepository translateRepository;

  bool isTranslating = false;
  bool isDetecting = false;
  TranslateResponseModel translateResponse =
      TranslateResponseModel.initial();

     DetectResponseModel detectResponse = DetectResponseModel.initial();
  
  /// This is the default language (initial state)
  /// It would be the language the user selects in settings
  String languageToBeTranslatedTo = "English";

  Future<void> languageDefault() async {
    try {
      String lang = await AppSharedPreference().getDefaultLanguage();
      languageToBeTranslatedTo =
          lang.isNotEmpty ? lang : "English"; // Fallback to a default value
      notifyListeners();
    } catch (e) {
      languageToBeTranslatedTo = "English"; // Fallback
      notifyListeners();
    }
  }

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


void updateIsDetecting(bool state) {
    isDetecting = state;
    notifyListeners();
  }
  void detectLanguage(String message) async {
    updateIsDetecting(true);
    detectResponse = await translateRepository.detectLanguageOfMessage(message);
    updateIsDetecting(false);
  }
}
