import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nfc_app/notifier/bottom_nav.dart';
import 'package:nfc_app/notifier/nfc_notifier.dart';
import 'package:nfc_app/presentation/screens/translate/notifier/language_notifier.dart';
import 'package:nfc_app/presentation/screens/translate/repository/translate_repository.dart';
import 'package:nfc_app/presentation/screens/welcome_screen.dart';
import 'package:nfc_app/themes/app_themes.dart';
import 'package:provider/provider.dart';

void main() async {
  try {
    await dotenv.load(fileName: ".env");
    // print("Env file loaded successfully");
  } catch (e) {
    // print("Error loading .env file: $e");
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NFCNotifier()),
        ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => LanguageNotifier(TranslateRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeData.lightMode,
        home:  const WelcomeScreen()
      ),
    );
  }
}


//* ui/watch-demo-screen