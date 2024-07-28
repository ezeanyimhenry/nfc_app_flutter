import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nfc_app/notifier/detect_language.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:nfc_app/presentation/widgets/custom_button.dart';
import 'package:nfc_app/presentation/widgets/languages_dropdown.dart';

class Translate extends StatefulWidget {
  const Translate({super.key});
  @override
  State<Translate> createState() => _TranslateState();
}

class _TranslateState extends State<Translate> {
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
  //  late final GenerativeModel _model;
  // late final ChatSession _chatSession;
  bool isResultVisible = false;
  TextEditingController textEditingController = TextEditingController();
  String generatedResult = '';
  String theDetectedLanguage = '';

  String? _selectedLanguage;

  @override
  // void initState() {
  //   super.initState();
  //   _model = GenerativeModel(
  //     model: "gemini-pro",
  //     apiKey: const String.fromEnvironment('api_key'),
  //   );
  //   _chatSession = _model.startChat();
  // }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  Future<void> translateContent(String input) async {
    try {
      if (apiKey.isEmpty) {
        print('No \$API_KEY environment variable');
      }
      // The Gemini 1.5 models are versatile and work with both text-only and multimodal prompts
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
      final content1 = [
        Content.text(
            'Translate simply to general $_selectedLanguage language, no unneccessary comments, just the translated result: $input'),
      ];
      final content2 = [
        Content.text(
            'Detect and display only the language of this text: $input'),
      ];

      final response1 = await model.generateContent(content1);
      final response2 = await model.generateContent(content2);

      setState(() {
        generatedResult = response1.text ?? 'No response received';
        theDetectedLanguage = response2.text ?? 'No response recieved';
        isResultVisible = true;
      });
    } catch (e) {
      setState(() {
        generatedResult = 'Sorry, I am not trained enough to translate this';
        print(generatedResult);
        isResultVisible = true;
      });
    }
  }

  // showDetectedLanguage() {
  //   setState(() {
  //     DetectLanguage(
  //         content: (textEditingController.text.isNotEmpty)
  //             ? textEditingController.text
  //             : "I am a boy");
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    void removeFocus() {
      FocusScope.of(context).unfocus();
    }

    void showResult() {
      // showDetectedLanguage();
      translateContent(textEditingController.text);
      // textEditingController.clear();
      removeFocus();
    }

    void clearResult() {
      setState(() {
        isResultVisible = false;
        // generatedResult = '';
        removeFocus();
      });
    }

    return GestureDetector(
      onTap: removeFocus,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Language Translator',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Montserrat',
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          fillColor: Theme.of(context).colorScheme.secondary,
                          filled: true,
                          label: const Text(
                            'Enter Text',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Detected Language:'),
                      const SizedBox(width: 2),
                      Container(
                        padding: const EdgeInsets.only(right: 25),
                        child: Text(theDetectedLanguage),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: LanguagesDropdown(
                    onLanguageSelected: (String? language) {
                      setState(() {
                        _selectedLanguage = language;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                // button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MyButton(
                          // icon: const Icon(
                          //   Icons.get_app,
                          //   size: 16,
                          //   color: Colors.white,
                          // ),
                          onTap: showResult,
                          buttonName: 'Translate',
                          // buttonColor:
                          // Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: MyButton(
                          // icon: const Icon(
                          //   Icons.delete,
                          //   size: 16,
                          //   color: Colors.white,
                          // ),
                          onTap: clearResult,
                          buttonName: 'Clear Result',
                          // buttonColor: Colors.red.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                // Result box
                Visibility(
                  visible: isResultVisible,
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                          child: Column(
                            children: [
                              Text(
                                // 'Text generated',
                                generatedResult,
                                style: const TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
