import 'package:cloud_firestore/cloud_firestore.dart';
import '../domain/note_model.dart';

class FirestoreNotesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference _notesRef(String uid) =>
      _db.collection('users').doc(uid).collection('notes');

  // Create
  Future<void> addNote(String uid, String title, String body) async {
    await _notesRef(uid).add({
      'title': title,
      'body': body,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Read (Real-time stream)
  Stream<List<Note>> getNotes(String uid) {
    return _notesRef(uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          id: doc.id,
          title: data['title'] ?? '',
          body: data['body'] ?? '',
          createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
          updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
        );
      }).toList();
    });
  }

  // Update
  Future<void> updateNote(String uid, String noteId, String title, String body) async {
    await _notesRef(uid).doc(noteId).update({
      'title': title,
      'body': body,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete
  Future<void> deleteNote(String uid, String noteId) async {
    await _notesRef(uid).doc(noteId).delete();
  }
}