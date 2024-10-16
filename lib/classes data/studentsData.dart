import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  String name;
  bool isPresent;

  Student({required this.name, this.isPresent = false});

  factory Student.fromFirestore(DocumentSnapshot doc) {
    return Student(
      name: doc['name'] ?? 'Unnamed Student',
      isPresent: doc['isPresent'] ?? false, // Adjust according to your Firestore structure
    );
  }
}
