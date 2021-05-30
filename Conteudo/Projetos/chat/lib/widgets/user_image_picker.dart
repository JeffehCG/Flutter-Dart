import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) onImagePick;
  UserImagePicker(this.onImagePick);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImageFile;

  Future<void> _pickImage() async {
    // Tirando foto
    final picker = ImagePicker();
    final pickerImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150
    );

    setState(() {
      _pickedImageFile = File(pickerImage.path);
    });

    widget.onImagePick(_pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          backgroundImage:
              _pickedImageFile != null ? FileImage(_pickedImageFile) : null,
        ),
        TextButton.icon(
          icon: Icon(Icons.image),
          label: Text('Adicionar Imagem'),
          onPressed: _pickImage,
        )
      ],
    );
  }
}
