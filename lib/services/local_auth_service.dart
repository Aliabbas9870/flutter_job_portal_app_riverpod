import 'dart:math';

import 'package:intl/intl.dart';
import 'package:job/model/user_profile.dart';

import 'local_db_service.dart';

class LocalAuthService {
  // micro helper id
  String _generateId() => DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(999).toString();

  Future<bool> signUp({
    required String email,
    required String password,
    required String fullName,
    String role = 'jobseeker',
  }) async {
    final users = await LocalDbService.readUsers();

    // check if email exists
    final exists = users.any((u) => u['email'] == email);
    if (exists) return false;

    final id = _generateId();
    final now = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());

    final profile = {
      'id': id,
      'email': email,
      'password': password,
      'fullName': fullName,
      'role': role,
      'createdAt': now,
    };
    users.add(profile);
    await LocalDbService.saveUsers(users);
    await LocalDbService.setCurrentUserId(id);
    return true;
  }

  Future<bool> signIn({ required String email, required String password }) async {
    final users = await LocalDbService.readUsers();
    final found = users.firstWhere(
      (u) => u['email'] == email && u['password'] == password,
      orElse: () => {},
    );
    if (found.isEmpty) return false;
    await LocalDbService.setCurrentUserId(found['id'] as String);
    return true;
  }

  Future<void> signOut() async {
    await LocalDbService.setCurrentUserId(null);
  }

  Future<bool> isLoggedIn() async {
    final id = await LocalDbService.getCurrentUserId();
    return id != null;
  }

  Future<UserProfile?> getCurrentProfile() async {
    final id = await LocalDbService.getCurrentUserId();
    if (id == null) return null;
    final users = await LocalDbService.readUsers();
    final found = users.firstWhere((u) => u['id'] == id, orElse: () => {});
    if (found.isEmpty) return null;
    return UserProfile.fromMap(found);
  }

  Future<void> updateProfile(UserProfile p) async {
    final users = await LocalDbService.readUsers();
    final idx = users.indexWhere((u) => u['id'] == p.id);
    if (idx == -1) return;
    users[idx] = p.toMap();
    await LocalDbService.saveUsers(users);
  }
}
