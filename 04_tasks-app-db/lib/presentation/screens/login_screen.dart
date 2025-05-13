import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/data/user_dao.dart';
import 'package:navigation/domain/user.dart';
import 'package:navigation/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _login() async {
    final UserDao userDao = database.userDao;
    final User? user = await userDao.getUserByUsername(usernameController.text);

    if (user != null && user.password == passwordController.text) {
      // Navigate to the home screen
      if(!mounted) return;
      context.go('/home', extra: user.username);
    } else {
      // Show an error message
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade800, Colors.blue.shade400],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo Placeholder
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.task_alt,
                    size: 50,
                    color: Colors.blue.shade800,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Tasks App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                // Username Field
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    // hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  // style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                // Password Field
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    // hintStyle: const TextStyle(color: Colors.white),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  // style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 30),
                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
