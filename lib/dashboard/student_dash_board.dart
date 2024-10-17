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

    List<Class> classList = await Future.wait(classesSnapshot.docs
        .map((doc) async => await Class.fromFirestore(doc)));

    return classList;
  }

  Future<void> enrollToClass(String classId) async {
    try {
      // Reference to the class document
      DocumentReference classRef =
          _firestore.collection('classes').doc(classId);

      // Reference to the user document in 'users' collection
      DocumentReference userRef = _firestore.collection('users').doc(userId);

      // Update the class document by adding the user reference to the students list
      await classRef.update({
        'students': FieldValue.arrayUnion([userRef]),
      });

      print('User enrolled successfully!');
    } catch (e) {
      print('Error enrolling user: $e');
    }
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

              return ListTile(
                title: Text(
                    'Class: ${classItem.name}'), // Displaying subjects as an example
                subtitle: Text('Teacher ID: ${classItem.teacher}'),
                trailing: ElevatedButton(
                  onPressed: () {
                    enrollToClass(classItem
                        .id); // Assuming teacher ID is used for class enrollment
                  },
                  child: Text('Enroll'),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF081A52)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
