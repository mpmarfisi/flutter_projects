import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Settings Screen'),
            ElevatedButton(
              onPressed: () {
                context.push('/profile');
              },
              child: const Text('Go to Profile'),
            ),
          ],
        ),
      ),
    );
  }
}