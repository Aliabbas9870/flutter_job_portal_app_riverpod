import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDbService {
  static const String _usersKey = 'local_users';
  static const String _jobsKey = 'local_jobs';
  static const String _applicationsKey = 'local_applications';
  static const String _currentUserKey = 'local_current_user_id';

  // USERS
  static Future<List<Map<String, dynamic>>> readUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_usersKey);
    if (s == null) return [];
    final List list = jsonDecode(s);
    return list.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> saveUsers(List<Map<String, dynamic>> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  // JOBS
  static Future<List<Map<String, dynamic>>> readJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_jobsKey);
    if (s == null) return [];
    final List list = jsonDecode(s);
    return list.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> saveJobs(List<Map<String, dynamic>> jobs) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_jobsKey, jsonEncode(jobs));
  }

  // APPLICATIONS
  static Future<List<Map<String, dynamic>>> readApplications() async {
    final prefs = await SharedPreferences.getInstance();
    final s = prefs.getString(_applicationsKey);
    if (s == null) return [];
    final List list = jsonDecode(s);
    return list.map<Map<String, dynamic>>((e) => Map<String, dynamic>.from(e)).toList();
  }

  static Future<void> saveApplications(List<Map<String, dynamic>> apps) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_applicationsKey, jsonEncode(apps));
  }

  // CURRENT USER
  static Future<void> setCurrentUserId(String? id) async {
    final prefs = await SharedPreferences.getInstance();
    if (id == null) {
      await prefs.remove(_currentUserKey);
    } else {
      await prefs.setString(_currentUserKey, id);
    }
  }

  static Future<String?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }
}
