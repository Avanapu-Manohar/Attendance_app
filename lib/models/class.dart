import 'package:cloud_firestore/cloud_firestore.dart';

class Class {
  final String id;
  final String teacher;
  final List<String> subjects; // List of subject names or IDs
  final List<String> studentIds; // List of student references (IDs)

  Class({
    required this.id,
    required this.teacher,
    required this.subjects,
    required this.studentIds,
  });

  // Factory constructor to map Firestore document to Class object
  factory Class.fromFirestore(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    return Class(
      id: doc.id,
      teacher: data['teacher'],
      subjects: List<String>.from(data['subjects'] ?? []),
      studentIds: List<String>.from(
          data['students'] ?? []), // Ensure the list of student IDs is not null
    );
  }
}
