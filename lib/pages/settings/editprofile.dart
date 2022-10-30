import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    if (_imageFile == null) return;
    final fileName = basename(_imageFile!.path);
    final destination = 'files/$fileName';

    try {
      final ref = FirebaseStorage.instance
          .ref(destination)
          .child('file/');
      await ref.putFile(_imageFile!);
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF231942),
      appBar: AppBar(
        backgroundColor: const Color(0xFF231942),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          Builder(
            builder: (context){
              return TextButton(
                child: const Text(
                  'SAVE ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                onPressed: () {},
              );
            },
          )
        ],
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: 20.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: const Color(0xFF2F2F2F),
                  child: _imageFile != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      _imageFile!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)),
                    width: 100,
                    height: 100,
                    child: Icon(
                      Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Divider(
              color: Color(0xFF9F86C0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
              child: TextFormField(
                initialValue: "Username",
                style: const TextStyle(
                  color: Color(0xFF9F86C0),
                ),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF322957),
                  border: OutlineInputBorder(),
                  label: Text(
                    "Username",
                    style: TextStyle(
                      color: Color(0xFF9F86C0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
              child: TextFormField(
                style: const TextStyle(
                  color: Color(0xFF9F86C0),
                ),
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color(0xFF322957),
                  border: OutlineInputBorder(),
                  label: Text(
                    "About Me",
                    style: TextStyle(
                      color: Color(0xFF9F86C0),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  tileColor: const Color(0xFFBE95C4),
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                  }),
                ListTile(
                  tileColor: const Color(0xFFBE95C4),
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
