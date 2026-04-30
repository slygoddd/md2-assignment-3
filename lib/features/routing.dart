import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Проверь, что пути к файлам ниже совпадают с твоей структурой папок
import 'auth/data/auth_providers.dart';
import 'auth/presentation/auth_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final user = authState.value;
      final isLoggingIn = state.matchedLocation == '/login';

      if (user == null) {
        return isLoggingIn ? null : '/login';
      }
      if (isLoggingIn) {
        return '/';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text('Мои заметки'),
            actions: [
              IconButton(
                onPressed: () => ref.read(authRepositoryProvider).signOut(),
                icon: const Icon(Icons.logout),
              ),
            ],
          ),
          body: const Center(child: Text('Связь установлена!')),
        ),
      ),
    ],
  );
});