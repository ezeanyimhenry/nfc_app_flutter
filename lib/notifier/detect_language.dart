import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class DetectLanguage extends StatefulWidget {
  final String content;
  const DetectLanguage({super.key, required this.content});

  @override
  State<DetectLanguage> createState() => _DetectLanguageState();
}

class _DetectLanguageState extends State<DetectLanguage> {
  String detectedLanguage = '';
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  Future<void> detectLanguage(String input) async {
    try {
      if (apiKey.isEmpty) {
        print('No \$API_KEY environment variable');
      }
      // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content = [
        Content.text(
            'What Language is this? return just the language name: $input'),
      ];
      final response = await model.generateContent(content);

      setState(() {
        if (input != 'I am a boy') {
          detectedLanguage = response.text ?? 'No language detected';
        }
        //   isResultVisible = true;
      });
    } catch (e) {
      setState(() {
        detectedLanguage = 'No language detected';
        // print(generatedResult);
        // isResultVisible = true;
      });
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    detectLanguage(widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return Text(detectedLanguage);
  }
}
