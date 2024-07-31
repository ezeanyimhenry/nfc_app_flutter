// import 'dart:convert';
// import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NFCNotifier extends ChangeNotifier {
  bool _isProcessing = false;
  String _message = "";

  bool get isProcessing => _isProcessing;

  String get message => _message;

  Future<void> startNFCOperation(
      {required NFCOperation nfcOperation, String content = ""}) async {
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
            _readFromTag(tag: nfcTag);
          } else if (nfcOperation == NFCOperation.write) {
            _writeToTag(nfcTag: nfcTag, content: content);
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
      _message = e.toString();git
      notifyListeners();
    }
  }

  Future<void> _readFromTag({required NfcTag tag}) async {
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
    }

    _message = decodedText ?? "No Data Found";
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
