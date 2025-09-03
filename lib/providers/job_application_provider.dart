import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/applied_job.dart';


class JobApplicationNotifier extends StateNotifier<List<AppliedJob>> {
  JobApplicationNotifier() : super([]);

  void applyToJob(AppliedJob job) {
    state = [...state, job];
  }
}

final jobApplicationProvider =
    StateNotifierProvider<JobApplicationNotifier, List<AppliedJob>>(
  (ref) => JobApplicationNotifier(),
);
