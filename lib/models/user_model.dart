// User sınıfı
class User {
  int id;
  String name;
  String email;
  String password;
  String company;
  DateTime createdAt;
  DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.company,
    required this.createdAt,
    this.updatedAt,
  });

  // JSON'dan User nesnesine dönüştürme metodu
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      company: json['company'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Map'den User nesnesine dönüştürme metodu
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      company: map['company'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt']!)
          : null,
    );
  }

  // User nesnesini JSON formatına dönüştürme metodu
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'company': company,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt!.toIso8601String(),
    };
  }
}
