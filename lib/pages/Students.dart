import 'package:flutter/material.dart';
import 'package:students_app/model/Student.dart';
import 'package:students_app/services/StudentService.dart';
import 'package:get/get.dart';
import 'package:students_app/controller/student_controller.dart';
import 'package:get/get.dart';

class Students extends StatefulWidget {
  const Students({super.key});

  @override
  State<Students> createState() => _StudentsState();
}

class _StudentsState extends State<Students> {
  late Future<List<Student>> futureStudents;
  TextEditingController searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final StudentController studentController = Get.put(StudentController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studentController.getAllStudents();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Students"),
        backgroundColor: Color.fromARGB(255, 176, 201, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15,bottom: 20),
              child:  Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                    child: Form(child: Row(
                      children: [
                        Expanded(child: TextFormField(
                          controller: searchController,
                          focusNode: _focusNode,
                          // onFieldSubmitted: (value){
                          //   searchForStudents(searchController.text);
                          // },
                          onChanged: (value){
                            studentController.searchStudents(searchController.text);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Search by name or email or phone",
                          ),
                        )),
                        // SizedBox(width: 10,),
                        // ElevatedButton(onPressed: (){
                        // searchForStudents(searchController.text);
                        // }, child: Text("Search",style: TextStyle(color: Colors.black),),style: ElevatedButton.styleFrom(backgroundColor: Colors.white70,),),
                      ],
                    )),
                  ),
                  Expanded(
                    child: Obx((){
                      if(studentController.isLoading.value){
                        return Center(child: CircularProgressIndicator());
                      }else if(studentController.studentList.isEmpty){
                        return Center(child: Text('No students found'));
                      }
                      else{
                        return ListView.builder(
                          itemCount: studentController.studentList.length,
                          itemBuilder: (context, index) {
                            final student = studentController.studentList[index];
                            print("--studentFirstName--${student.firstName}");
                            print("--studentLastName--${student.lastName}");
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(child: Container(
                                child: ListTile(
                                    title:  Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Name : ${student.firstName}"),
                                          Text("Prenom: ${student.lastName}"),
                                          Text("Email: ${student.email}"),
                                          Text("Phone: ${student.phone}")
                                        ],
                                      ),
                                    ),
                                    // subtitle: ,
                                    trailing: Container(
                                      width: 60,
                                      child: Row(
                                        children: [
                                          InkWell(
                                              onTap: (){
                                                Get.toNamed("/editstudent",arguments: student.id)?.then((_){
                                                  studentController.getAllStudents();
                                                });
                                              },
                                              child: Icon(Icons.edit,color: Colors.grey)),
                                          SizedBox(width: 5,),
                                          InkWell(
                                              onTap: () async {
                                              showDialogScreen(context, student.id!, student.phone);
                                              },
                                              child: Icon(Icons.delete,color: Colors.red)),
                                        ],
                                      ),
                                    )
                                ),
                              ),),
                            );
                          },
                        );
                      }
                    }),
                  ),
                ],
              ),

      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
        onPressed: (){
          Get.toNamed("/addstudent")?.then((_){
            studentController.getAllStudents();
          });
        },
      ),
    );
  }

void showDialogScreen(BuildContext context,int id,String phone){
    showDialog(context: context, builder: (cntx){
      return AlertDialog(
        title: Text("Confirm Deleting"),
        content: Text("Are you sure you want to delete this student with id : $id And phone : $phone"),
        actions: [
          ElevatedButton(onPressed: (){
          Get.back();
          }, child: Text("Cancel")),
          ElevatedButton(onPressed: () async{
            bool deleted = await  StudentService().deleteStudent(id);
            if(deleted){
              studentController.getAllStudents();
            }
            Get.back();
          }, child: Text("Delete"))
        ],
      );
    });
}
}
