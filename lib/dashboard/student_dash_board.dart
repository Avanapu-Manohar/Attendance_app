import 'package:attendence_app/models/class.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentsDashBoard extends StatelessWidget {
  final String userId;

  StudentsDashBoard({required this.userId});

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the classes for the teacher from Firestore
  Future<List<Class>> fetchClasses() async {
    var classesSnapshot =
    await FirebaseFirestore.instance.collection('classes').get();

    // Mapping Firestore data to Class model
    List<Class> classList = await Future.wait(
      classesSnapshot.docs.map((doc) async => await Class.fromFirestore(doc)),
    );

    return classList;
  }

  Future<void> enrollToClass(String classId) async {
    try {
      DocumentReference classRef = _firestore.collection('classes').doc(classId);
      DocumentReference userRef = _firestore.collection('users').doc(userId);

      await classRef.update({
        'students': FieldValue.arrayUnion([userRef]), // Add user reference
      });

      print('User enrolled successfully!');
    } catch (e) {
      print('Error enrolling user: $e');
    }
  }

  // Check if user is enrolled in any class
  bool isUserEnrolledInClass(Class classItem) {
    // Check if the students list is in the document data
    // This requires a slight modification in fetching the classes
    return classItem.studentIds.contains(userId); // This is still referring to the list, ensure this is valid in your model
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text(
          'Student Dashboard',
          style: TextStyle(
            color: Color(0xFF081A52),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<Class>>(
        future: fetchClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No classes available.'));
          }

          List<Class> classList = snapshot.data!;

          return ListView.builder(
            itemCount: classList.length,
            itemBuilder: (context, index) {
              final classItem = classList[index];

              // Check if user is enrolled in the current class
              bool isEnrolled = isUserEnrolledInClass(classItem);

              return ListTile(
                title: Text('Class: ${classItem.name}'),
                subtitle: Text('Teacher ID: ${classItem.teacher}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    if (!isEnrolled) {
                      enrollToClass(classItem.id);
                    }
                  },
                  child: Text(isEnrolled ? 'Enrolled' : 'Enroll'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF081A52),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
