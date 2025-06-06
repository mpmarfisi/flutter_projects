import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/presentation/screens/home_screen.dart';
import 'package:navigation/presentation/screens/login_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        final username = state.extra as String; // Explicitly cast to String
        return HomeScreen(username: username);
      },
    ),
    // Add more routes here
  ],
);