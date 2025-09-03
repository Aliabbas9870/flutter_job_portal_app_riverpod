import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/model/user_profile.dart';

import '../services/local_auth_service.dart';

class AuthNotifier extends StateNotifier<UserProfile?> {
  final LocalAuthService _authService;
  AuthNotifier(this._authService) : super(null) {
    _load();
  }

  Future<void> _load() async {
    final p = await _authService.getCurrentProfile();
    state = p;
  }

  Future<String?> signUp({
    required String email,
    required String password,
    required String fullName,
    String role = 'jobseeker',
  }) async {
    final ok = await _authService.signUp(email: email, password: password, fullName: fullName, role: role);
    if (!ok) return "User already exists";
    await _load();
    return null;
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    final ok = await _authService.signIn(email: email, password: password);
    if (!ok) return "Invalid credentials";
    await _load();
    return null;
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = null;
  }

  Future<void> refresh() async => _load();
}

final localAuthProvider = StateNotifierProvider<AuthNotifier, UserProfile?>((ref) {
  return AuthNotifier(LocalAuthService());
});
