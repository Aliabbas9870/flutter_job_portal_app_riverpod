import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/model/job.dart';

import '../services/local_db_service.dart';

class JobNotifier extends StateNotifier<List<Job>> {
  JobNotifier(): super([]) {
    _load();
  }

  Future<void> _load() async {
    final items = await LocalDbService.readJobs();
    state = items.map((m) => Job.fromMap(m)).toList().reversed.toList();
  }

  String _genId() => DateTime.now().millisecondsSinceEpoch.toString() + Random().nextInt(999).toString();

  Future<void> addJob({
    required String recruiterId,
    required String title,
    required String company,
    required String location,
    required String salary,
    required String description,
  }) async {
    final id = _genId();
    final now = DateTime.now().toIso8601String();
    final job = Job(
      id: id,
      recruiterId: recruiterId,
      title: title,
      company: company,
      location: location,
      salary: salary,
      description: description,
      createdAt: now,
    );
    final current = (await LocalDbService.readJobs()).toList();
    current.add(job.toMap());
    await LocalDbService.saveJobs(current);
    await _load();
  }

  Future<Job?> getById(String id) async {
    final list = state;
    try {
      return list.firstWhere((j) => j.id == id);
    } catch (e) {
      return null;
    }
  }
}

final jobProvider = StateNotifierProvider<JobNotifier, List<Job>>((ref) => JobNotifier());
