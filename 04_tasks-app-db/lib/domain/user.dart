class User {
  final String username;
  final String name;
  final String email;
  final String password;
  final String? imageUrl;
  final DateTime bornDate;

  User({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.bornDate,
    this.imageUrl
  });

  @override
  String toString() {
    return 'User{username: $username, name: $name, email: $email, password: $password}';
  }
}
