import 'dart:async';
import 'package:flutter/services.dart';
import 'package:android_intent/android_intent.dart';
import 'package:android_intent/flag.dart';

class NfcBroadcastReceiver {
  final MethodChannel _channel = const MethodChannel('nfc_broadcast_receiver');
  final StreamController<dynamic> _eventController =
      StreamController.broadcast();

  NfcBroadcastReceiver() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onNfcDiscovered':
        // Prevent default action by sending a broadcast
        final AndroidIntent intent = AndroidIntent(
          action: 'android.intent.action.VIEW',
          data: Uri.parse('http://www.example.com').toString(),
          package: 'com.example.nfc_app',
          componentName: 'com.example.nfc_app/.MainActivity',
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
        _eventController.add(call.arguments);
        break;
      default:
        throw UnimplementedError('Method ${call.method} not implemented');
    }
    return null;
  }

  Stream<dynamic> get events => _eventController.stream;

  void listen() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  void dispose() {
    _eventController.close();
  }
}
