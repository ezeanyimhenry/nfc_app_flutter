import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nfc_app/notifier/nfc_notifier.dart';
import 'package:nfc_app/presentation/screens/home_screen.dart';
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
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
