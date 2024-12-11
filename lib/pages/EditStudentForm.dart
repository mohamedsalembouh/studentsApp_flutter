import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_app/model/Student.dart';
import 'package:students_app/services/StudentService.dart';

class Editstudentform extends StatefulWidget {
   Editstudentform({super.key});
  @override
  State<Editstudentform> createState() => _EditstudentformState();
}

class _EditstudentformState extends State<Editstudentform> {

  late Future<Student> futureStudent ;

  final int? id = Get.arguments as int?;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (id != null) {
      futureStudent = StudentService().getStudent(id!);
    } else {
      futureStudent = Future.error("Student ID not provided");
    }
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController nomController = TextEditingController();
    TextEditingController prenomController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController adreseController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Update Student"),),
      body: FutureBuilder<Student>(
        future: futureStudent,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            Student student = snapshot.data!;
            print("----data----$student");
            nomController.text = student.firstName;
            prenomController.text=student.lastName;
            phoneController.text=student.phone;
            emailController.text=student.email;
            adreseController.text=student.adresse;
            return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Container(
                child: Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: nomController,
                        decoration: InputDecoration(label: Text("Name")),
                      ),
                      TextFormField(
                        controller: prenomController,
                        decoration: InputDecoration(label: Text("Prenom")),
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(label: Text("Phone")),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(label: Text("Email")),
                      ),
                      TextFormField(
                        controller: adreseController,
                        decoration: InputDecoration(label: Text("Adrese")),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text("Cancel",style: TextStyle(color: Colors.white,fontSize: 14),),
                                style: ElevatedButton.styleFrom(backgroundColor:  Colors.red,),
                              ),
                            ),
                            SizedBox(width: 10,),
                            SizedBox(
                              width: MediaQuery.of(context).size.width*0.4,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Student student = Student(firstName: nomController.text, lastName: prenomController.text, adresse: adreseController.text, email: emailController.text, phone: phoneController.text);
                                  await StudentService().updateStudent(student,id!);
                                  // Get.offAllNamed("/allstudents");
                                  Get.back();
                                },
                                child: Text("Update",style: TextStyle(color: Colors.white,fontSize: 14),),
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }else{
            return Container();
          }
        }
      ),
    );
  }
}
