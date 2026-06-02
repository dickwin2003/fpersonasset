class User {
  final String userId;
  final String username;
  final String? phone;
  final String? email;
  final String createdAt;
  final String updatedAt;

  User({
    required this.userId,
    required this.username,
    this.phone,
    this.email,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['user_id'] as String,
      username: map['username'] as String,
      phone: map['phone'] as String?,
      email: map['email'] as String?,
      createdAt: map['created_at'] as String,
      updatedAt: map['updated_at'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'username': username,
      'phone': phone,
      'email': email,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  User copyWith({
    String? username,
    String? phone,
    String? email,
  }) {
    return User(
      userId: userId,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );
  }
}
