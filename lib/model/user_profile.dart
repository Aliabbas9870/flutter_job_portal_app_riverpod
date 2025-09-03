class UserProfile {
  final String id;
  final String email;
  final String password; // stored locally (not secure) — for demo only
  final String fullName;
  final String role; // "jobseeker" or "recruiter"
  final String createdAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.password,
    required this.fullName,
    required this.role,
    required this.createdAt,
  });

  factory UserProfile.fromMap(Map<String, dynamic> m) => UserProfile(
        id: m['id'] as String,
        email: m['email'] as String,
        password: m['password'] as String,
        fullName: m['fullName'] as String,
        role: m['role'] as String,
        createdAt: m['createdAt'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'email': email,
        'password': password,
        'fullName': fullName,
        'role': role,
        'createdAt': createdAt,
      };
}
