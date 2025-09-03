import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/application.dart';
import '../services/local_db_service.dart';

class ApplicationNotifier extends StateNotifier<List<ApplicationModel>> {
  ApplicationNotifier(): super([]) {
    _load();
  }

  Future<void> _load() async {
    final items = await LocalDbService.readApplications();
    state = items.map((m) => ApplicationModel.fromMap(m)).toList().reversed.toList();
  }

  String _genId() => DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(999).toString();

  Future<void> apply({
    required String jobId,
    required String seekerId,
    String resumeUrl = '',
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

  Future<List<ApplicationModel>> forJob(String jobId) async {
    return state.where((a) => a.jobId == jobId).toList();
  }

  Future<List<ApplicationModel>> forUser(String userId) async {
    return state.where((a) => a.seekerId == userId).toList();
  }
}

final applicationProvider = StateNotifierProvider<ApplicationNotifier, List<ApplicationModel>>((ref) => ApplicationNotifier());
