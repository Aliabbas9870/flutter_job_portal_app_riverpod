import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/providers/auth_provider.dart';
import 'package:job/providers/job_provider.dart';
import 'package:job/view/auth/login_view.dart';
import 'package:job/view/jobs/applied_job_view.dart';
import 'package:job/view/jobs/job_detail_view.dart';
import 'package:job/view/jobs/post_job_view.dart';
import 'package:job/view/users/profile_view.dart';
import 'package:job/widget/job_card.dart';


class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(localAuthProvider);
    final jobs = ref.watch(jobProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Portal'),
        actions: [
          IconButton(onPressed: () {
            ref.read(localAuthProvider.notifier).signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginView()));
          }, icon: const Icon(Icons.logout)),
          IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileView())), icon: const Icon(Icons.person)),
        ],
      ),
     floatingActionButton: (user != null && user.role == 'recruiter')
    ? FloatingActionButton(
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (_) => const PostJobView())),
        child: const Icon(Icons.add),
      )
    : (user != null && user.role == 'jobseeker')
        ? FloatingActionButton(
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (_) => const AppliedJobsView())),
            child: const Icon(Icons.folder_open),
          )
          : null,
      body: jobs.isEmpty
          ? const Center(child: Text('No jobs yet.'))
          : ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, i) {
                final job = jobs[i];
                return JobCard(
                  job: job,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => JobDetailView(jobId: job.id))),
                );
              },
            ),
    );
  }
}
