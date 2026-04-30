import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_auth_repository.dart';
import '../domain/auth_repository.dart';

// Создаем сам репозиторий
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return FirebaseAuthRepository();
});

// Создаем поток, который говорит: "Пользователь внутри" или "Снаружи" 
final authStateProvider = StreamProvider((ref) {
  return ref.read(authRepositoryProvider).authStateChanges;
});