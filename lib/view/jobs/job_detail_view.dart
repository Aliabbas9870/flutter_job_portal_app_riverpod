// view/jobs/job_detail_view.dart
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../providers/application_provider.dart'; // ✅ Use correct provider
import '../../providers/auth_provider.dart';
import '../../providers/job_provider.dart';

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

      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf", "doc", "docx"],
      );

      if (result != null && result.files.single.path != null) {
        final pickedFile = File(result.files.single.path!);

        // Save resume into app docs directory
        final appDir = await getApplicationDocumentsDirectory();
        final resumesDir = Directory("${appDir.path}/resumes");
        if (!await resumesDir.exists()) {
          await resumesDir.create(recursive: true);
        }
        final fileName = p.basename(pickedFile.path);
        final savedPath = "${resumesDir.path}/$fileName";
        await pickedFile.copy(savedPath);

        // ✅ Save in LocalDb through provider
        await ref.read(applicationProvider.notifier).apply(
              jobId: job.id,
              seekerId: user.id,
              resumeUrl: savedPath, // ✅ store actual path
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
            Text(job.company,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(job.description,
                style: const TextStyle(fontSize: 16, height: 1.4)),
            const Spacer(),
            if (user?.role == "jobseeker")
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
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
