class Job {
  final String id;
  final String recruiterId;
  final String title;
  final String company;
  final String location;
  final String salary;
  final String description;
  final String createdAt;

  Job({
    required this.id,
    required this.recruiterId,
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.description,
    required this.createdAt,
  });

  factory Job.fromMap(Map<String, dynamic> m) => Job(
        id: m['id'] as String,
        recruiterId: m['recruiterId'] as String,
        title: m['title'] as String,
        company: m['company'] as String,
        location: m['location'] as String,
        salary: m['salary'] as String,
        description: m['description'] as String,
        createdAt: m['createdAt'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'recruiterId': recruiterId,
        'title': title,
        'company': company,
        'location': location,
        'salary': salary,
        'description': description,
        'createdAt': createdAt,
      };
}
