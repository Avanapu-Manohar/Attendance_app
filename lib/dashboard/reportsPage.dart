import 'package:flutter/material.dart';

import 'attendenceScreen.dart';
class ReportsPage extends StatefulWidget {
  ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  String? ClassChoose;
  String? SubjectChoose;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Attendance Report Screen',style: TextStyle(
            color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700
        ),),
      ),
      body: Center(
        child: Column(
          children: [
            Text('Reports for a list of classes',style: TextStyle(
              color: Colors.black,fontSize: 18,fontWeight: FontWeight.w700
            ),),
            SizedBox(height: 25,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton(
                    hint: const Text('Select an class'),
                    value: ClassChoose,
                    items: ["Class 6","Class 7","Class 8","Class 9","Class 10"].map((String value){
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged:(String? newValue){
                      setState(() {
                        ClassChoose=newValue!;
                      });
                    }),
                SizedBox(width: 15,),
                DropdownButton(
                    hint: const Text('Select a subject'),

                    value: SubjectChoose,
                    items: ["Maths","Science","Social Studies","Telugu","Hindi"].map((String value){
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged:(String? newValue){
                      setState(() {
                        SubjectChoose=newValue!;
                      });
                    }),
              ],
            ),
            SizedBox(height: 25,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => AttendenceScreen(userId: '',)));
            },
              style:  ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text (and icon) color
              ),
              child: Text('Enter',style: TextStyle(
                fontWeight: FontWeight.w500,fontSize: 18,
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
