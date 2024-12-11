import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:students_app/model/Student.dart';
import 'package:students_app/services/StudentService.dart';

class StudentController extends GetxController{
  RxList<Student> studentList = <Student>[].obs;
  RxBool isLoading = false.obs;

  searchStudents(String key) async{
    isLoading(true);
 try{
   if(key.isNotEmpty){
     studentList.value = await StudentService().searchStudent(key);
   }else{
     studentList.value = await StudentService().getAllStudents();
   }
 }catch(e){
   print("error: $e");
   throw Exception("");
 }finally{
   isLoading(false);
 }
  }

  getAllStudents() async{
    isLoading(true);
    try{
      studentList.value = await StudentService().getAllStudents();
    }catch(e){
      throw("Error");
    }finally{
      isLoading(false);
  }
  }
}