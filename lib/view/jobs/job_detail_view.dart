import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/model/applied_job.dart';
import 'package:job/providers/job_provider.dart';

import '../../providers/auth_provider.dart';
import '../../providers/job_application_provider.dart';

class JobDetailView extends ConsumerWidget {
  final String jobId;
  const JobDetailView({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(localAuthProvider);
    final jobs = ref.watch(jobProvider);
    final job = jobs.firstWhere((j) => j.id == jobId);

    Future<void> _applyJob() async {
      if (user == null || user.role != "jobseeker") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Only Job Seekers can apply")),
        );
        return;
      }

      final result = await FilePicker.platform.pickFiles(type: FileType.any);
      if (result != null && result.files.single.path != null) {
        final resumePath = result.files.single.path!;

        ref.read(jobApplicationProvider.notifier).applyToJob(
              AppliedJob(
                jobId: job.id,
                title: job.title,
                company: job.company,
                resumePath: resumePath,
              ),
            );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Applied successfully with resume")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text(job.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.company, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text(job.description),
            const Spacer(),
            if (user?.role == "jobseeker")
              ElevatedButton.icon(
                onPressed: _applyJob,
                icon: const Icon(Icons.upload_file),
                label: const Text("Apply & Upload Resume"),
              ),
          ],
        ),
      ),
    );
  }
}
