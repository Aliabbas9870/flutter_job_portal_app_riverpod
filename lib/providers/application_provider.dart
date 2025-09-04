import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/application.dart';
import '../services/local_db_service.dart';

class ApplicationNotifier extends StateNotifier<List<ApplicationModel>> {
  ApplicationNotifier() : super([]) {
    _load();
  }

  /// 🔹 Load all applications from local storage
  Future<void> _load() async {
    final items = await LocalDbService.readApplications();
    state = items.map((m) => ApplicationModel.fromMap(m)).toList().reversed.toList();
  }

  /// 🔹 Generate a unique ID
  String _genId() =>
      DateTime.now().millisecondsSinceEpoch.toString() +
      Random().nextInt(999).toString();

  /// 🔹 Apply for a job (saves application locally)
  Future<void> apply({
    required String jobId,
    required String seekerId,
    required String resumeUrl, // ✅ make required
  }) async {
    final id = _genId();
    final now = DateTime.now().toIso8601String();

    final app = ApplicationModel(
      id: id,
      jobId: jobId,
      seekerId: seekerId,
      resumeUrl: resumeUrl,
      status: 'applied',
      appliedAt: now,
    );

    final current = (await LocalDbService.readApplications()).toList();
    current.add(app.toMap());
    await LocalDbService.saveApplications(current);
    await _load();
  }

  /// 🔹 Get applications for a specific job
  Future<List<ApplicationModel>> forJob(String jobId) async {
    return state.where((a) => a.jobId == jobId).toList();
  }

  /// 🔹 Get applications submitted by a specific user
  Future<List<ApplicationModel>> forUser(String userId) async {
    return state.where((a) => a.seekerId == userId).toList();
  }

  /// 🔹 Update application status (e.g., accepted/rejected)
  Future<void> updateStatus(String id, String newStatus) async {
    final current = (await LocalDbService.readApplications()).toList();
    final index = current.indexWhere((a) => a['id'] == id);
    if (index != -1) {
      current[index]['status'] = newStatus;
      await LocalDbService.saveApplications(current);
      await _load();
    }
  }
}

/// ✅ Provider to use across app
final applicationProvider =
    StateNotifierProvider<ApplicationNotifier, List<ApplicationModel>>(
        (ref) => ApplicationNotifier());
