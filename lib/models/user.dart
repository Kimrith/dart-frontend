class User {
  final int id;
  final String userName;
  final String email;
  final DateTime dateOfBirth;

  User({
    required this.id,
    required this.userName,
    required this.email,
    required this.dateOfBirth,
  });

  // Safe JSON Parsing: protects against missing fields or null values
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int? ?? 0,
      userName: json['userName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'])
          : DateTime.now(),
    );
  }
}