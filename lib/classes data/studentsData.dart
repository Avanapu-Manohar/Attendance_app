class Student{
  final String name;
  bool isPresent;
  Student({required this.name,this.isPresent=false});
}
List<Student> students = [
  Student(name: 'John Doe'),
  Student(name: 'Jane Smith'),
  Student(name: 'Tommy Adams'),
  Student(name: 'Emily Johnson'),
  Student(name: 'Michael Clark'),
];