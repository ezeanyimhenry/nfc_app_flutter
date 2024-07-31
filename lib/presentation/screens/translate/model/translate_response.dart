class TranslateAndDetectResponse {
  const TranslateAndDetectResponse({
    required this.isSuccessful,
    this.errorMessage,
    this.detectedLanguage,
    this.translatedMessage,
  });
  final String? translatedMessage;
  final String? detectedLanguage;
  final bool isSuccessful;
  final String? errorMessage;

  factory TranslateAndDetectResponse.initial() =>
      const TranslateAndDetectResponse(
        isSuccessful: false,
      );
}
