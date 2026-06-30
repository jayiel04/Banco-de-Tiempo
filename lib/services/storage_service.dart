import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const _keyUserName = 'userName';
  static const _keyTotalGemas = 'totalGemas';
  static const _keyTotalFocusSeconds = 'totalFocusSeconds';
  static const _keyTotalRestSeconds = 'totalRestSeconds';
  static const _keyTasks = 'tasks';

  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserName, name);
  }

  static Future<String?> loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUserName);
  }

  static Future<void> saveTotalGemas(int gemas) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTotalGemas, gemas);
  }

  static Future<int> loadTotalGemas() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalGemas) ?? 0;
  }

  static Future<void> saveTotalFocusSeconds(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTotalFocusSeconds, seconds);
  }

  static Future<int> loadTotalFocusSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalFocusSeconds) ?? 0;
  }

  static Future<void> saveTotalRestSeconds(int seconds) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyTotalRestSeconds, seconds);
  }

  static Future<int> loadTotalRestSeconds() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_keyTotalRestSeconds) ?? 0;
  }

  static const _keyProfilePhotoPath = 'profilePhotoPath';

  static Future<void> saveProfilePhotoPath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyProfilePhotoPath, path);
  }

  static Future<String?> loadProfilePhotoPath() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyProfilePhotoPath);
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final json = jsonEncode(tasks.map((t) => t.toJson()).toList());
    await prefs.setString(_keyTasks, json);
  }

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final json = prefs.getString(_keyTasks);
    if (json == null) return [];
    final list = jsonDecode(json) as List;
    return list.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList();
  }
}
