import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String _validUsername = 'user123';
  final String _validPassword = 'pass123';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login Screen',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  // hintText: 'Enter your username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  // hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  final username = usernameController.text;
                  final password = passwordController.text;

                  if (username == _validUsername && password == _validPassword) {
                    context.go('/home', extra: username);
                  } else {
                    final snackBar = SnackBar(
                      content: const Text('Invalid username or password'),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          passwordController.clear();
                          usernameController.clear();
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
