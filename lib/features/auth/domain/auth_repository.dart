import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  // Следит, вошел пользователь или нет
  Stream<User?> get authStateChanges;
  
  // Регистрация
  Future<UserCredential> signUp(String email, String password);
  
  // Вход
  Future<UserCredential> signIn(String email, String password);
  
  // Выход
  Future<void> signOut();
}