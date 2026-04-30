import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firestore_notes_repository.dart';
import '../../auth/data/auth_providers.dart';
import '../domain/note_model.dart';

final notesRepositoryProvider = Provider((ref) => FirestoreNotesRepository());

// Провайдер, который автоматически подгружает список заметок [cite: 49]
final notesStreamProvider = StreamProvider<List<Note>>((ref) {
  final user = ref.watch(authStateProvider).value;
  if (user == null) return Stream.value([]);
  return ref.watch(notesRepositoryProvider).getNotes(user.uid);
});