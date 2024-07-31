class TranslateDTO {
  const TranslateDTO({
    required this.message,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  final String sourceLanguage, targetLanguage;
  final String message;
}
