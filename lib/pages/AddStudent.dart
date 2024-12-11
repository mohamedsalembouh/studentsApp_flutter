import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:students_app/model/Student.dart';
import 'package:students_app/services/StudentService.dart';
import 'package:students_app/widgets/image_input.dart';
class AddStudent extends StatelessWidget {
  const AddStudent({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nomController = TextEditingController();
    TextEditingController prenomController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController adreseController = TextEditingController();
   // final formKey =
    return Scaffold(
      appBar: AppBar(title: Text("Add Student"),),
      body: Padding(
        padding: const EdgeInsets.only(left: 10,right: 10),
        child: Container(
          child: Form(
            //key: ,
            child: Column(
              children: [
                TextFormField(
                  controller: nomController,
                  decoration: InputDecoration(label: Text("Name")),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "please entere a valid data";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: prenomController,
                  decoration: InputDecoration(label: Text("Prenom")),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "please entere a valid data";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(label: Text("Phone")),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "please entere a valid data";
                    }
                    if(!isValidPhone(value)){
                      return "phone number must be 8 character";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(label: Text("Email")),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "please enter a valid data";
                    }
                    if(!isValidEmail(value)){
                      return "Email not valid";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: adreseController,
                  decoration: InputDecoration(label: Text("Adrese")),
                ),
                ImageInput(),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width *0.4,
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
                        width: MediaQuery.of(context).size.width *0.4,
                        child: ElevatedButton(
                          onPressed: () async {
                            Student student = Student(firstName: nomController.text, lastName: prenomController.text, adresse: adreseController.text, email: emailController.text, phone: phoneController.text);
                            await StudentService().addStudent(student);
                            // Get.offAllNamed("/");
                            Get.back();
                          },
                          child: Text("Save",style: TextStyle(color: Colors.white,fontSize: 14),),
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
      ),
    );
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool isValidPhone(String number){
    if(number.length==8) {
      return true;
    }
    else {
      return false;
    }
  }


}
