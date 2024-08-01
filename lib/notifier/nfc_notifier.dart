import 'package:flutter/material.dart';
import 'package:nfc_app/notifier/nfc_broadcast_receiver.dart';
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

  final NfcBroadcastReceiver _nfcBroadcastReceiver;

  NFCNotifier() : _nfcBroadcastReceiver = NfcBroadcastReceiver() {
    _nfcBroadcastReceiver.events.listen((event) {
      // Update state based on the NFC event
      _readContent = event.toString();
      _isProcessing = false; // NFC operation is complete
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _nfcBroadcastReceiver.dispose();
    super.dispose();
  }

  Future<void> startNFCOperation({
    required NFCOperation nfcOperation,
    String content = "",
    required BuildContext context,
  }) async {
    //history

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
    Map<String, dynamic> nfcData = {
      'nfca': tag.data['nfca'],
      'mifareultralight': tag.data['mifareultralight'],
      'ndef': tag.data['ndef']
    };

    String? decodedText;
    if (nfcData.containsKey('ndef')) {
      List<int> payload =
          nfcData['ndef']['cachedMessage']?['records']?[0]['payload'] ?? [];

      if (payload.isNotEmpty) {
        decodedText = _decodeNdefText(payload);
        _showProcess = true;
      }
    }

    _readContent = decodedText ?? "No Data Found";
    // _message = _readContent;
    notifyListeners();

    if (decodedText != null && decodedText.isNotEmpty) {
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
                    builder: (context) => TextFoundScreen(foundText: readContent),
                  ),
                );
              },
              message: "Make sure your device is well placed.",
              title: "Scan Successful!",
              centerContent: const ProgressIndicatorWithText(
                progress: 1.0,
              ),
            ),
          );
        },
      );
    }
  }

  String _decodeNdefText(List<int> payload) {
    if (payload.isEmpty) return "";

    int statusByte = payload[0];
    int languageCodeLength = statusByte & 0x1F;
    List<int> textBytes = payload.sublist(1 + languageCodeLength);

    return String.fromCharCodes(textBytes);
  }

  Future<void> _writeToTag({
    required NfcTag nfcTag,
    required String content,
    required BuildContext context,
  }) async {
    NdefMessage message = _createNdefMessage(content: content);
    await Ndef.from(nfcTag)?.write(message);
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
            title: "Write Successful!",
            centerContent: const ProgressIndicatorWithText(
              progress: 1.0,
            ),
          ),
        );
      },
    );
  }

  NdefMessage _createNdefMessage({required String content}) {
    return NdefMessage([NdefRecord.createText(content)]);
  }

  void _handleError(dynamic error) {
    _isProcessing = false;
    _message = error.toString();
    notifyListeners();
    NfcManager.instance.stopSession();
  }
}

enum NFCOperation { read, write }
