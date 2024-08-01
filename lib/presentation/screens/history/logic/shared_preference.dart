import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../models/history_model.dart';

class AppSharedPreference {
  // Save list of HistoryModel to SharedPreferences
  Future<void> saveHistoryList(List<HistoryModel> historyList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        historyList.map((model) => jsonEncode(model.toJson())).toList();
    await prefs.setStringList('history_list', jsonList);
  }

// Get list of HistoryModel from SharedPreferences
  Future<List<HistoryModel>> getHistoryList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('history_list');
    if (jsonList == null) {
      return [];
    }
    return jsonList
        .map((jsonStr) => HistoryModel.fromJson(jsonDecode(jsonStr)))
        .toList();
  }

  setDefaultLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('defaultLanguage', language);
  }

  getDefaultLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get('defaultLanguage');
  }
}
