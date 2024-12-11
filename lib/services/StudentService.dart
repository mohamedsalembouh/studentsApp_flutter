import 'dart:convert';

import 'package:students_app/model/Student.dart';
import 'package:students_app/utils/Constants.dart';
import 'package:http/http.dart' as http;

class StudentService {
  final String allStudentUrl = "${Constants.baseUrl}/all";
  final String addStudentUrl = "${Constants.baseUrl}/add";
  final String deleteStudentUrl = "${Constants.baseUrl}/delete";
  final String updateStudentUrl = "${Constants.baseUrl}/update";
  final String searchStudentUrl= "${Constants.baseUrl}/search";

  Future<List<Student>> getAllStudents() async {
    final response = await http.get(Uri.parse(allStudentUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      print("-----response--- ${jsonResponse.toString()}");
      return jsonResponse.map((student) => Student.fromJson(student)).toList();
    } else {
      print("-----there is an exception-------");
      throw Exception("Failed to load students");
    }
  }

  Future<Student> addStudent(Student student) async {
    final response = await http.post(
      Uri.parse(addStudentUrl),
      headers: {"Content-Type": "application/json"},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      print("----status---${response.statusCode}");
      throw Exception("Failed to add student");
    }
  }
  Future<bool> deleteStudent(int id) async {
    final response = await http.delete(
      Uri.parse("$deleteStudentUrl/$id"),
    );
    if (response.statusCode == 200) {
      print(json.decode(response.body));
      return json.decode(response.body);
    } else {
      print("----status---${response.statusCode}");
      throw Exception("Failed to delete student");
    }
  }
  Future<Student> getStudent(int id) async{
    final response = await http.get(Uri.parse("${Constants.baseUrl}/$id"));
    if(response.statusCode==200){
      return Student.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to get student");
    }
  }
  Future<Student> updateStudent(Student student,int id) async{
    final response = await http.put(Uri.parse("${updateStudentUrl}/$id"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(student.toJson())
    );
    if(response.statusCode==200){
      return Student.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to update Student");
    }
  }

  Future<List<Student>> searchStudent(String key) async{
    final response = await http.get(Uri.parse("${searchStudentUrl}/$key"));
    if(response.statusCode==200){
      print("----ok----");
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((student)=>Student.fromJson(student)).toList();
    }else{
      throw Exception("There is an error");
    }
  }
  
  
}
