class AppliedJob {
  final String jobId;
  final String title;
  final String company;
  final String resumePath; // local path to resume file

  AppliedJob({
    required this.jobId,
    required this.title,
    required this.company,
    required this.resumePath,
  });
}
