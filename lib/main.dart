import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:students_app/pages/AddStudent.dart';
import 'package:students_app/pages/EditStudentForm.dart';
import 'package:students_app/pages/Students.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      home: Students(),
      getPages: [
        GetPage(name: "/", page:()=> Students()),
        GetPage(name: "/addstudent", page:()=> AddStudent()),
        GetPage(name: "/editstudent", page:()=> Editstudentform()),
      ],
    );
  }
}

