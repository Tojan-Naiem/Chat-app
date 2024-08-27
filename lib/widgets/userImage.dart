import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  void _pickImage() async{
  final XFile? _pickedImage=  await ImagePicker().pickImage(
source: ImageSource.camera,
maxHeight: 150,
imageQuality: 50,
    );
    if(_pickedImage==null)return;
    setState(() {
      _pickedImageFile=File(_pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
           CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            foregroundImage:_pickedImageFile==null?null: FileImage(_pickedImageFile!),
           ),
           TextButton.icon(
            onPressed: (){
              _pickImage();
            },
            icon: Icon(Icons.image),
             label: Text(
              'Add image',
              style: TextStyle(color: Theme.of(context).primaryColor),
              )
             )
      ],
    );
  }
}