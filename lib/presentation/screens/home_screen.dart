import 'package:flutter/material.dart';
import 'package:nfc_app/notifier/nfc_notifier.dart';
import 'package:nfc_app/presentation/screens/translate_screen.dart';
import 'package:nfc_app/presentation/widgets/dialog_box.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TextEditingController();
  // int _counter = 0;

  writeToNfc() {
    Provider.of<NFCNotifier>(context, listen: false).startNFCOperation(
        nfcOperation: NFCOperation.write, content: controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NFCNotifier(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // scanningDialog(context);
                      Provider.of<NFCNotifier>(context, listen: false)
                          .startNFCOperation(nfcOperation: NFCOperation.read);
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text('Scanning Tag'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(height: 16),
                                Text('Please wait...'),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: const Text("READ NFC"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DialogBox(
                            controller: controller,
                            onSave: writeToNfc,
                            onCancel: () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                    child: const Text("WRITE TO NFC TAG"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return DialogBox(
                      //       controller: controller,
                      //       onSave: writeToNfc,
                      //       onCancel: () {
                      //         Navigator.pop(context);
                      //       },
                      //     );
                      //   },
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Translate()),
                      );
                    },
                    child: const Text("TRANSLATE"),
                  ),
                  Consumer<NFCNotifier>(builder: (context, provider, _) {
                    if (provider.isProcessing) {
                      return const CircularProgressIndicator();
                    }
                    if (provider.message.isNotEmpty) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.pop(context);
                        // showResultDialog(context, provider.message);
                      });
                    }
                    return const SizedBox();
                  }),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'Read Tag',
          child: const Icon(Icons.search),
        ),
      ),
    );
  }
}
