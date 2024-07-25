/* class ClientModel {
  final int? id;
  final String? name;
  final String? email;
  final String? password;
  final String? createdAt;

  ClientModel({
    this.id,
    required this.name,
    required this.email,
    this.password,
    this.createdAt,
  });

  // Factory method to create a User from JSON
  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
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
} */
// client_model.dart
class ClientModel {
  int? id;
  final String? name;
  final String? phone;
  final String? description;
  final String? city;
  final String? category;
  final String? employeeId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClientModel({
    this.id,
    this.name,
    this.phone,
    this.description,
    this.city,
    this.category,
    this.employeeId,
    this.createdAt,
    this.updatedAt,
  });
  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};
    result.addAll({'id': id ?? 0});
    result.addAll({'name': name});
    result.addAll({'phone': phone});
    result.addAll({'description': description});
    result.addAll({'city': city});
    result.addAll({'category': category});
    result.addAll({'employeeId': employeeId});
    result.addAll({'created_at': createdAt});
    result.addAll({'updated_at': updatedAt});
    return result;
  }

  factory ClientModel.fromMap(Map<String, dynamic> map) {
    return ClientModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      phone: map['phone'] ?? '',
      description: map['description'] ?? '',
      city: map['city'] ?? '',
      category: map['category'] ?? '',
      employeeId: map['employeeId'] ?? '',
      createdAt: map['created_at'] ?? '',
      updatedAt: map['updated_at'] ?? '',
    );
  }
}
