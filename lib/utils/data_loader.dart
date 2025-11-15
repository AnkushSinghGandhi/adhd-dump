import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/dump.dart';
import '../models/reminder.dart';
import '../models/cart_item.dart';
import '../models/suggestion.dart';

class DataLoader {
  static Future<List<Dump>> loadDumps() async {
    final String jsonString = await rootBundle.loadString('assets/fixtures/dumps.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Dump.fromJson(json)).toList();
  }

  static Future<List<Reminder>> loadReminders() async {
    final String jsonString = await rootBundle.loadString('assets/fixtures/reminders.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Reminder.fromJson(json)).toList();
  }

  static Future<List<CartItem>> loadCartItems() async {
    final String jsonString = await rootBundle.loadString('assets/fixtures/cart_items.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => CartItem.fromJson(json)).toList();
  }

  static Future<Map<String, dynamic>> loadSuggestions() async {
    final String jsonString = await rootBundle.loadString('assets/fixtures/suggestions.json');
    return json.decode(jsonString);
  }

  static List<AnimeSuggestion> parseAnimeSuggestions(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => AnimeSuggestion.fromJson(json)).toList();
  }

  static List<ShoppingSuggestion> parseShoppingSuggestions(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => ShoppingSuggestion.fromJson(json)).toList();
  }

  static List<StudySuggestion> parseStudySuggestions(List<dynamic>? jsonList) {
    if (jsonList == null) return [];
    return jsonList.map((json) => StudySuggestion.fromJson(json)).toList();
  }
}
