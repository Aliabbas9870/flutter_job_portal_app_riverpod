import 'package:flutter/material.dart';
import 'package:job/model/job.dart';


class JobCard extends StatelessWidget {
  final Job job;
  final VoidCallback onTap;
  const JobCard({super.key, required this.job, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        title: Text(job.title, style: const TextStyle(fontWeight: FontWeight.w700)),
        subtitle: Text("${job.company} • ${job.location}"),
        trailing: Text(job.salary),
      ),
    );
  }
}
