// view/jobs/applied_jobs_view.dart
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
                return Card(
                  margin: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.work, color: Colors.green),
                    title: Text(job.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Text("${job.company}\nResume: ${job.resumePath.split('/').last}"),
                    isThreeLine: true,
                    trailing: const Icon(Icons.check_circle, color: Colors.blue),
                  ),
                );
              },
            ),
    );
  }
}
