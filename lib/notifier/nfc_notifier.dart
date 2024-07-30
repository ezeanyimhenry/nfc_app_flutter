// import 'dart:convert';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_app/presentation/screens/translate/translate_screen.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCNotifier extends ChangeNotifier {
  bool _isProcessing = false;
  bool _showProcess = false;
  String _message = "";
  String _readContent = "";

  bool get isProcessing => _isProcessing;
  bool get showProcess => _showProcess;
  String get message => _message;

  Future<void> startNFCOperation(
      {required NFCOperation nfcOperation,
      String content = "",
      required BuildContext context}) async {
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

        NfcManager.instance.startSession(onDiscovered: (NfcTag nfcTag) async {
          if (nfcOperation == NFCOperation.read) {
            await _readFromTag(tag: nfcTag, context: context);
          } else if (nfcOperation == NFCOperation.write) {
            await _writeToTag(nfcTag: nfcTag, content: content);
            _message = "DONE";
          }

          _isProcessing = false;
          notifyListeners();
          await NfcManager.instance.stopSession();
        }, onError: (e) async {
          _isProcessing = false;
          _message = e.toString();
          notifyListeners();
        });
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

  Future<void> _readFromTag(
      {required NfcTag tag, required BuildContext context}) async {
    Map<String, dynamic> nfcData = {
      'nfca': tag.data['nfca'],
      'mifareultralight': tag.data['mifareultralight'],
      'ndef': tag.data['ndef']
    };

    String? decodedText;
    if (nfcData.containsKey('ndef')) {
      // Extract the NDEF record payload
      List<int> payload =
          nfcData['ndef']['cachedMessage']?['records']?[0]['payload'];

      if (payload.isNotEmpty) {
        // Decode the NFC text payload correctly
        decodedText = _decodeNdefText(payload);
        _showProcess = true;
      }
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

  String _decodeNdefText(List<int> payload) {
    if (payload.isEmpty) return "";

    // The first byte contains the status information
    int statusByte = payload[0];
    // Language code length is encoded in the lower 5 bits of the first byte
    int languageCodeLength = statusByte & 0x1F;
    // Extract the actual text, skipping the language code length
    List<int> textBytes = payload.sublist(1 + languageCodeLength);

    return String.fromCharCodes(textBytes);
  }

  Future<void> _writeToTag(
      {required NfcTag nfcTag, required String content}) async {
    NdefMessage message = _createNdefMessage(content: content);
    await Ndef.from(nfcTag)?.write(message);
  }

  NdefMessage _createNdefMessage({required String content}) {
    return NdefMessage([NdefRecord.createText(content)]);
  }
}

enum NFCOperation { read, write }
