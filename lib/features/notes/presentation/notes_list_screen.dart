import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/notes_providers.dart';
import '../../auth/data/auth_providers.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Слушаем поток заметок из Firestore
    final notesAsync = ref.watch(notesStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заметки'),
        actions: [
          IconButton(
            onPressed: () => ref.read(authRepositoryProvider).signOut(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: notesAsync.when(
        data: (notes) => notes.isEmpty
            ? const Center(child: Text('Заметок пока нет. Нажми +'))
            : ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.body),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        final uid = ref.read(authStateProvider).value?.uid;
                        if (uid != null) {
                          ref.read(notesRepositoryProvider).deleteNote(uid, note.id);
                        }
                      },
                    ),
                    onTap: () => _showNoteDialog(context, ref, note),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: Text('Ошибка: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNoteDialog(context, ref, null),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showNoteDialog(BuildContext context, WidgetRef ref, dynamic note) {
    final titleController = TextEditingController(text: note?.title ?? '');
    final bodyController = TextEditingController(text: note?.body ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(note == null ? 'Новая заметка' : 'Редактировать'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(hintText: 'Заголовок')),
            TextField(controller: bodyController, decoration: const InputDecoration(hintText: 'Текст')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Отмена')),
          ElevatedButton(
            onPressed: () {
              final uid = ref.read(authStateProvider).value?.uid;
              if (uid != null) {
                final repo = ref.read(notesRepositoryProvider);
                if (note == null) {
                  repo.addNote(uid, titleController.text, bodyController.text);
                } else {
                  repo.updateNote(uid, note.id, titleController.text, bodyController.text);
                }
              }
              Navigator.pop(context);
            },
            child: const Text('Сохранить'),
          ),
        ],
      ),
    );
  }
}