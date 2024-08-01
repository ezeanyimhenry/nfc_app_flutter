class TranslateResponseModel {
  const TranslateResponseModel({
    required this.isSuccessful,
    this.errorMessage,
    this.translatedMessage,
  });
  final String? translatedMessage;
  final bool isSuccessful;
  final String? errorMessage;

  factory TranslateResponseModel.initial() =>
      const TranslateResponseModel(
        isSuccessful: false,
      );
}

class DetectResponseModel {
  const DetectResponseModel({
    required this.isSuccessful,
    this.errorMessage,
    this.detectedLanguage,
  });
  final String? detectedLanguage;
  final bool isSuccessful;
  final String? errorMessage;

  factory DetectResponseModel.initial() =>
      const DetectResponseModel(
        isSuccessful: false,
      );
}
