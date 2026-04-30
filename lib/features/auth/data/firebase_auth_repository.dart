import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../domain/auth_repository.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _storage = const FlutterSecureStorage();

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  @override
  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> signIn(String email, String password) async {
    final credential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    
    // Task 2: Получаем JWT токен и сохраняем его в сейф 
    final token = await credential.user?.getIdToken();
    if (token != null) {
      await _storage.write(key: 'jwt_token', value: token);
    }
    
    return credential;
  }

  @override
  Future<void> signOut() async {
    await _storage.delete(key: 'jwt_token'); // Очищаем сейф при выходе [cite: 40]
    await _auth.signOut();
  }
}