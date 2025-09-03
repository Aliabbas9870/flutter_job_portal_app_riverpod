import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/providers/application_provider.dart';
import 'package:job/providers/auth_provider.dart';
import 'package:job/providers/job_provider.dart';


class JobDetailView extends ConsumerWidget {
  final String jobId;
  const JobDetailView({super.key, required this.jobId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final job = ref.read(jobProvider.notifier).getById(jobId);
    final user = ref.watch(localAuthProvider);

    return FutureBuilder(
      future: job,
      builder: (context, snap) {
        if (!snap.hasData) return const Scaffold(body: Center(child: CircularProgressIndicator()));
        final j = snap.data!;
        return Scaffold(
          appBar: AppBar(title: Text(j.title)),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(j.title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('${j.company} • ${j.location}'),
              const SizedBox(height: 10),
              Text('Salary: ${j.salary}'),
              const SizedBox(height: 12),
              Expanded(child: SingleChildScrollView(child: Text(j.description))),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (user == null || user.role == 'recruiter')
                      ? null
                      : () async {
                          await ref.read(applicationProvider.notifier).apply(jobId: j.id, seekerId: user.id);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Applied successfully')));
                        },
                  child: const Text('Apply Now'),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
