import 'package:nfc_app/presentation/screens/translate/model/language_data.dart';

enum HistoryType { read, written }

class HistoryModel {
  final LanguageType label;
  final String language;
  final DateTime date;
  final String actualText;
  final HistoryType type;

  HistoryModel({
    required this.label,
    required this.language,
    required this.date,
    required this.actualText,
    required this.type,
  });

  // Convert HistoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'label': label.toString().split('.').last,
      'language': language,
      'date': date.toIso8601String(),
      'actualText': actualText,
      'type': type.toString().split('.').last, // Convert enum to string
    };
  }

  // Create HistoryModel from JSON
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      label: LanguageType.values
          .firstWhere((e) => e.toString().split('.').last == json['label']),
      language: json['language'],
      date: DateTime.parse(json['date']),
      actualText: json['actualText'],
      type: HistoryType.values
          .firstWhere((e) => e.toString().split('.').last == json['type']),
    );
  }
}
