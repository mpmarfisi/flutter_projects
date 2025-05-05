import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigation/presentation/screens/detail_screen.dart';
import 'package:navigation/presentation/screens/home_screen.dart';
import 'package:navigation/presentation/screens/login_screen.dart';
import 'package:navigation/presentation/screens/profile_screen.dart';
import 'package:navigation/presentation/screens/settings_screen.dart';

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
    GoRoute(
     path: '/task-details/:taskId', 
     builder: (context, state) {
      final taskId = state.pathParameters['taskId'];
      return DetailScreen(
        taskId: taskId!,
      );
    }),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen()
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen()
    ),
    // Add more routes here
  ],
);