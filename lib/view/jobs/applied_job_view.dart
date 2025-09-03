import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/job_application_provider.dart';

class AppliedJobsView extends ConsumerWidget {
  const AppliedJobsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appliedJobs = ref.watch(jobApplicationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("My Applications")),
      body: appliedJobs.isEmpty
          ? const Center(child: Text("No applications yet."))
          : ListView.builder(
              itemCount: appliedJobs.length,
              itemBuilder: (context, i) {
                final job = appliedJobs[i];
                return ListTile(
                  leading: const Icon(Icons.work),
                  title: Text(job.title),
                  subtitle: Text("Resume: ${job.resumePath.split('/').last}"),
                );
              },
            ),
    );
  }
}
