import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
class ImageInput extends StatefulWidget {
   ImageInput({super.key});

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;

  // void takePicture() async{
  //   final imagePicker = ImagePicker();
  //  final pickedImage = await imagePicker.pickImage(source: ImageSource.gallery,maxWidth: 600);
  //  if(pickedImage==null){
  //    return;
  //  }
  // setState(() {
  //   _selectedImage = File(pickedImage.path);
  // });
  // }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(onPressed: (){}, label: Text("Pick an image"),icon: Icon(Icons.image),);
    if(_selectedImage!=null){
      content = Image.file(_selectedImage!,fit: BoxFit.cover,);
    }
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2)
        )
      ),
      width: double.infinity,
      height: 150,
      alignment: Alignment.center,
      child: content,
    );
  }
}
