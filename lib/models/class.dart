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
    List<DocumentReference> studentsRefs =
        List<DocumentReference>.from(doc['students']);
    List<DocumentReference> subjectsRefs =
        List<DocumentReference>.from(doc['subjects']);
    DocumentReference teacherRef = doc['teacher'];
    List<String> studentIDs = studentsRefs.map((ref) => ref.id).toList();
    List<String> subjectIDs = subjectsRefs.map((ref) => ref.id).toList();
    String teacherID = teacherRef.id;

    return Class(
        id: doc.id,
        teacher: teacherID,
        subjects: subjectIDs,
        studentIds: studentIDs);
  }
}
