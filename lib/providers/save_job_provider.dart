import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedJobs extends StateNotifier<Set<String>> {
  SavedJobs() : super(<String>{});

  void toggle(String jobId) {
    final s = Set<String>.from(state);
    if (s.contains(jobId)) {
      s.remove(jobId);
    } else {
      s.add(jobId);
    }
    state = s;
  }

  bool isSaved(String jobId) => state.contains(jobId);
}

final savedJobsProvider =
    StateNotifierProvider<SavedJobs, Set<String>>((ref) => SavedJobs());
