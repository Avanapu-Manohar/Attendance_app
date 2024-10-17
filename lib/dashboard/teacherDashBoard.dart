import 'package:attendence_app/dashboard/attendance_screen.dart';
import 'package:attendence_app/dashboard/reports_page.dart';
import 'package:flutter/material.dart';

import 'attendance.dart';
class TeacherDashboard extends StatelessWidget {
  final String userId;
  TeacherDashboard({required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Teacher dashboard',style: TextStyle(
          color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700
        ),),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Student Attendance Portal',style: TextStyle(
              fontSize: 18,fontWeight: FontWeight.w700,color: Colors.black
            ),),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceScreen(userId: 'userId',)));
                },
                    style:  ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text (and icon) color
                    ),
                    child: Text('Take Attendence',style: TextStyle(
                      fontWeight: FontWeight.w500,fontSize: 18,
                    ),),
                ),
                SizedBox(width: 15,),
                ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReportsPage()));
                },
                  style:  ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text (and icon) color
                  ),
                  child: Text('Reports',style: TextStyle(
                    fontWeight: FontWeight.w500,fontSize: 18,
                  ),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
