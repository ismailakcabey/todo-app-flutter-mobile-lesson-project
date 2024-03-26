class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String company;
  final DateTime createdAt;
  final DateTime updatedAt;
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.company,
    required this.createdAt,
    required this.updatedAt,
  });
}
