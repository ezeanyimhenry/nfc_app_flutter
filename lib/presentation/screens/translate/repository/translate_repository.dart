import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_dto.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_response.dart';

class TranslateRepository {
  Future<TranslateAndDetectResponse> translateMessage(
    TranslateDTO dto,
  ) async {
    final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

    try {
      if (apiKey.isEmpty) {}

      // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content1 = [
        Content.text(
            'Translate simply to general ${dto.targetLanguage} language, no unneccessary comments, just the translated result: ${dto.message}'),
      ];
      final content2 = [
        Content.text(
            'Detect and display only the language of this text, no unneccessary comments, just the detected language name: ${dto.message}'),
      ];
      final translateResponse = await model.generateContent(content1);
      final detectResponse = await model.generateContent(content2);

      return TranslateAndDetectResponse(
        isSuccessful: true,
        detectedLanguage: detectResponse.text ?? "Unable to detect",
        translatedMessage: translateResponse.text ?? "No response, try again",
      );
    } on SocketException {
      return const TranslateAndDetectResponse(
        isSuccessful: false,
        errorMessage: "Kindly check your internet connection",
      );
    } on GenerativeAIException catch (e) {
      return TranslateAndDetectResponse(
        isSuccessful: false,
        errorMessage: e.message,
      );
    } catch (e) {
      return const TranslateAndDetectResponse(
        isSuccessful: false,
        errorMessage: 'Sorry, I am not trained enough to translate this',
      );
    }
  }
}
