import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_dto.dart';
import 'package:nfc_app/presentation/screens/translate/model/translate_response.dart';

class TranslateRepository {
  Future<DetectResponseModel> detectLanguageOfMessage(String message) async {
    final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    
    final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
    try {
      final content2 = [
        Content.text(
            'Detect and display only the language of this text, no unneccessary comments, just the detected language name: $message'),
      ];
      final detectResponse = await model.generateContent(content2);
      print("dtctdRsp => ${detectResponse.text}");
      return DetectResponseModel(
        isSuccessful: true,
        detectedLanguage: detectResponse.text ?? "No response, try again",
      );
    } on SocketException {
      return DetectResponseModel(
        isSuccessful: false,
        errorMessage: "Kindly check your internet connection",
      );
    }on GenerativeAIException catch (e) {
      return DetectResponseModel(
        isSuccessful: false,
        errorMessage: e.message,
      );
    } catch (e) {
      return const DetectResponseModel(
        isSuccessful: false,
        errorMessage: 'Sorry, I am not trained enough to detect this',
      );
    }
  }

  Future<TranslateResponseModel> translateMessage(
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
     
      final translateResponse = await model.generateContent(content1);

      return TranslateResponseModel(
        isSuccessful: true,
        translatedMessage: translateResponse.text ?? "No response, try again",
      );
    } on SocketException {
      return const TranslateResponseModel(
        isSuccessful: false,
        errorMessage: "Kindly check your internet connection",
      );
    } on GenerativeAIException catch (e) {
      return TranslateResponseModel(
        isSuccessful: false,
        errorMessage: e.message,
      );
    } catch (e) {
      return const TranslateResponseModel(
        isSuccessful: false,
        errorMessage: 'Sorry, I am not trained enough to translate this',
      );
    }
  }
}
