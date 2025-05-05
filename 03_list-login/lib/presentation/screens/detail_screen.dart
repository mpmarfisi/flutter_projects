import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget{
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Detail Screen!',
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}