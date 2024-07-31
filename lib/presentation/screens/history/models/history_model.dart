enum HistoryType { Read, Written }

class HistoryModel {
  final String language;
  final DateTime date;
  final String actualText;
  final HistoryType type;

  HistoryModel({
    required this.language,
    required this.date,
    required this.actualText,
    required this.type,
  });

  // Convert HistoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'language': language,
      'date': date.toIso8601String(),
      'actualText': actualText,
      'type': type.toString().split('.').last, // Convert enum to string
    };
  }

  // Create HistoryModel from JSON
  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      language: json['language'],
      date: DateTime.parse(json['date']),
      actualText: json['actualText'],
      type: HistoryType.values.firstWhere((e) => e.toString().split('.').last == json['type']),
    );
  }
}
