enum LanguageType {
  source("Source"),
  target("Target");

  const LanguageType(this.label);
  final String label;
}

class LanguageData {
  const LanguageData({
    required this.content,
    required this.type,
    required this.name,
  });
  final LanguageType type;
  final String content, name;
}
