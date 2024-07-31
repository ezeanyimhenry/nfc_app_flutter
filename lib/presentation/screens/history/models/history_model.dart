import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';

class HistoryData {
  const HistoryData({
    required this.translation,
    required this.date,
  });
  final LanguageData translation;
  final DateTime date;

  addHistory() {}
}
