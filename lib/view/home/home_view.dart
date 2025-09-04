import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job/core/app_color.dart';
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
      backgroundColor: AppColors.background,

      /// 🔹 Animated AppBar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primary
            .withOpacity(0.9), // Slightly transparent background
        title: const Text(
          'Job Portal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            tooltip: "Logout",
            onPressed: () {
              ref.read(localAuthProvider.notifier).signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginView()),
              );
            },
            icon: const Icon(Icons.logout),
          ),
          IconButton(
            tooltip: "Profile",
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileView()),
            ),
            icon: const Icon(Icons.person),
          ),
        ],
      ),

      /// 🔹 FAB based on role
      floatingActionButton: user == null
          ? null
          : (user.role == 'recruiter'
              ? FloatingActionButton.extended(
                  tooltip: "Post Job",
                  backgroundColor: Colors.green[700],
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PostJobView()),
                  ),
                  icon: const Icon(Icons.add),
                  label: const Text("Post Job"),
                )
              : (user.role == 'jobseeker'
                  ? FloatingActionButton.extended(
                      tooltip: "My Applications",
                      backgroundColor: Colors.blueAccent,
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AppliedJobsView()),
                      ),
                      icon: const Icon(Icons.folder_open),
                      label: const Text("My Applications"),
                    )
                  : null)),

      /// 🔹 Animated Job List
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: jobs.isEmpty
            ? const Center(
                key: ValueKey("empty"),
                child: Text(
                  'No jobs yet.',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              )
            : ListView.builder(
                key: const ValueKey("list"),
                padding: const EdgeInsets.all(12),
                itemCount: jobs.length,
                itemBuilder: (context, i) {
                  final job = jobs[i];
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => JobDetailView(jobId: job.id),
                        ),
                      ),
                      child: Hero(
                        tag: job.id,
                        child: JobCard( job: job, onTap: () => Navigator.push( context, MaterialPageRoute( builder: (_) => JobDetailView(jobId: job.id), ), ), ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
