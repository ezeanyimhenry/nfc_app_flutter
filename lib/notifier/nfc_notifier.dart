import 'package:flutter/material.dart';
import 'package:nfc_app/presentation/screens/home.dart';
import 'package:nfc_app/presentation/screens/translate/text_found_screen.dart';
import 'package:nfc_app/presentation/widgets/app_bottom_sheet.dart';
import 'package:nfc_app/presentation/widgets/circle_progress_indicator.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCNotifier extends ChangeNotifier {
  bool _isProcessing = false;
  bool _showProcess = false;
  String _message = "";
  String _readContent = "";

  bool get isProcessing => _isProcessing;
  bool get showProcess => _showProcess;
  String get message => _message;
  String get readContent => _readContent;

  Future<void> startNFCOperation({
    required NFCOperation nfcOperation,
    String content = "",
    required BuildContext context,
  }) async {
    try {
      _isProcessing = true;
      _message =
          nfcOperation == NFCOperation.read ? "Scanning..." : "Writing To Tag";
      notifyListeners();

      bool isAvail = await NfcManager.instance.isAvailable();

      if (isAvail) {
        await NfcManager.instance.startSession(
          onDiscovered: (NfcTag nfcTag) async {
            if (nfcOperation == NFCOperation.read) {
              await _readFromTag(tag: nfcTag, context: context);
            } else if (nfcOperation == NFCOperation.write) {
              await _writeToTag(
                  nfcTag: nfcTag, content: content, context: context);
              _message = "DONE";
            }

            _isProcessing = false;
            notifyListeners();
            await NfcManager.instance.stopSession();
          },
          onError: (e) async {
            _handleError(e);
          },
        );
      } else {
        _message = "Please Enable NFC From Settings";
        _isProcessing = false;
        notifyListeners();
      }
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _readFromTag({
    required NfcTag tag,
    required BuildContext context,
  }) async {
    var ndef = Ndef.from(tag);

    if (ndef == null) {
      _message = "Tag is not readable";
      _readContent = _message;
      _showProcess = false;
      notifyListeners();
      return;
    }

    try {
      NdefMessage message = await ndef.read();
      String decodedText = String.fromCharCodes(message.records.first.payload);
      _readContent = decodedText;
      _message = "Scan Successful!";
      _showProcess = true;
      notifyListeners();

      showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: AppBottomsheet(
              hasPrimaryButton: true,
              primaryButtonText: "Continue",
              primaryButtonOnTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        TextFoundScreen(foundText: _readContent),
                  ),
                );
              },
              message: "",
              title: _message,
              centerContent: const ProgressIndicatorWithText(
                progress: 1.0,
              ),
            ),
          );
        },
      );
    } catch (e) {
      _handleError(e);
    }
  }

  Future<void> _writeToTag({
    required NfcTag nfcTag,
    required String content,
    required BuildContext context,
  }) async {
    try {
      NdefMessage message = NdefMessage([
        NdefRecord.createText(content),
      ]);
      await Ndef.from(nfcTag)?.write(message);
      _message = "Write Successful!";
      _showProcess = true;
      notifyListeners();

      showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: AppBottomsheet(
              hasPrimaryButton: true,
              primaryButtonText: "Continue",
              primaryButtonOnTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(initialIndex: 0),
                  ),
                );
              },
              message: "",
              title: _message,
              centerContent: const ProgressIndicatorWithText(
                progress: 1.0,
              ),
            ),
          );
        },
      );
    } catch (e) {
      _handleError(e);
    }
  }

  void _handleError(dynamic error) {
    _isProcessing = false;
    _message = error.toString();
    notifyListeners();
    NfcManager.instance.stopSession();
  }
}

enum NFCOperation { read, write }
