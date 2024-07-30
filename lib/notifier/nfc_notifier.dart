import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_app/presentation/screens/translate/translate_screen.dart';

class NFCNotifier extends ChangeNotifier {
  bool _isProcessing = false;
  bool _showProcess = false;
  String _message = "";
  String _readContent = "";

  bool get isProcessing => _isProcessing;
  bool get showProcess => _showProcess;
  String get message => _message;

  Future<void> startNFCOperation({
    required NFCOperation nfcOperation,
    String content = "",
    required BuildContext context,
  }) async {
    try {
      _isProcessing = true;
      notifyListeners();

      bool isAvail = await NfcManager.instance.isAvailable();

      if (isAvail) {
        if (nfcOperation == NFCOperation.read) {
          _message = "Scanning...";
        } else if (nfcOperation == NFCOperation.write) {
          _message = "Writing To Tag";
        }

        notifyListeners();

        // Start NFC session
        await NfcManager.instance.startSession(
          onDiscovered: (NfcTag nfcTag) async {
            try {
              if (nfcOperation == NFCOperation.read) {
                await _readFromTag(tag: nfcTag, context: context);
              } else if (nfcOperation == NFCOperation.write) {
                await _writeToTag(nfcTag: nfcTag, content: content);
                _message = "DONE";
              }
            } finally {
              // Ensure session is stopped after operation completes
              _isProcessing = false;
              notifyListeners();
              await NfcManager.instance.stopSession();
            }
          },
          onError: (e) async {
            // Handle error and stop session
            _isProcessing = false;
            _message = e.toString();
            notifyListeners();
            await NfcManager.instance.stopSession();
          },
        );
      } else {
        _isProcessing = false;
        _message = "Please Enable NFC From Settings";
        notifyListeners();
      }
    } catch (e) {
      _isProcessing = false;
      _message = e.toString();
      notifyListeners();
    }
  }

  Future<void> _readFromTag({
    required NfcTag tag,
    required BuildContext context,
  }) async {
    Map<String, dynamic> nfcData = {
      'nfca': tag.data['nfca'],
      'mifareultralight': tag.data['mifareultralight'],
      'ndef': tag.data['ndef']
    };

    String? decodedText;
    if (nfcData.containsKey('ndef')) {
      List<int> payload =
          nfcData['ndef']['cachedMessage']?['records']?[0]['payload'];
      decodedText = String.fromCharCodes(payload);
      _showProcess = true;
    }

    _readContent = decodedText ?? "No Data Found";
    _message = _readContent;

    // Navigate to TranslateScreen with the read content
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TranslateScreen(message: _readContent),
      ),
    );
  }

  Future<void> _writeToTag({
    required NfcTag nfcTag,
    required String content,
  }) async {
    NdefMessage message = _createNdefMessage(content: content);
    await Ndef.from(nfcTag)?.write(message);
  }

  NdefMessage _createNdefMessage({required String content}) {
    return NdefMessage([NdefRecord.createText(content)]);
  }
}

enum NFCOperation { read, write }
