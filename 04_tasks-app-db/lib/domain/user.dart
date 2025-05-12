import 'package:floor/floor.dart';

@Entity(tableName: 'User')
class User {
  @primaryKey
  final String username;
  final String name;
  final String email;
  final String password;
  final String? imageUrl;
  final String bornDate; // Changed from DateTime to String

  User({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
    required this.bornDate, // Updated type
    this.imageUrl,
  });

  @override
  String toString() {
    return 'User{username: $username, name: $name, email: $email, password: $password}';
  }
}
