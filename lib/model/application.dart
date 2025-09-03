class ApplicationModel {
  final String id;
  final String jobId;
  final String seekerId;
  final String resumeUrl;
  final String status; // applied, reviewed, accepted, rejected
  final String appliedAt;

  ApplicationModel({
    required this.id,
    required this.jobId,
    required this.seekerId,
    required this.resumeUrl,
    required this.status,
    required this.appliedAt,
  });

  factory ApplicationModel.fromMap(Map<String, dynamic> m) => ApplicationModel(
        id: m['id'] as String,
        jobId: m['jobId'] as String,
        seekerId: m['seekerId'] as String,
        resumeUrl: m['resumeUrl'] as String,
        status: m['status'] as String,
        appliedAt: m['appliedAt'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'jobId': jobId,
        'seekerId': seekerId,
        'resumeUrl': resumeUrl,
        'status': status,
        'appliedAt': appliedAt,
      };
}
