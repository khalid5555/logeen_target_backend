class UserModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? createdAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.password,
    this.createdAt,
  });

  // Factory method to create a User from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      name: json['name'],
      email: json['email'],
      password: json['password'],
      createdAt: json['created_at'],
    );
  }

  // Method to convert a User to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'created_at': createdAt,
    };
  }
}
