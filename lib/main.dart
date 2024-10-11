import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();  // Firebase 초기화
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const ImagePickerApp(),  // MaterialApp으로 ImagePickerApp 감싸기
    );
  }
}


class ImagePickerApp extends StatefulWidget {
  const ImagePickerApp({super.key});


  @override
  State<ImagePickerApp> createState() => _ImagePickerAppState();
}


class _ImagePickerAppState extends State<ImagePickerApp> {
  ImagePicker picker = ImagePicker();
  File? selectedImage;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: pickImageFromGallery, icon: const Icon(Icons.image)),
          IconButton(onPressed: uploadImage, icon: const Icon(Icons.check)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _selectedImage(),
            _imageGallery(),
          ],
        ),
      ),
    );
  }


  Widget _selectedImage() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Center(
        child: (selectedImage == null)
            ? const Icon(
          Icons.image_not_supported,
          color: Colors.white,
          size: 100,
        )
            : Image.file(
          selectedImage!,
          fit: BoxFit.fill,
        ),
      ),
    );
  }


  Widget _imageGallery() {
    return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            mainAxisSpacing: 1.0, crossAxisSpacing: 1.0, crossAxisCount: 3),
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
        ));
  }



  Future<void> pickImageFromGallery() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }


  Future<void> uploadImage() async {
    if (selectedImage != null) {
      final now = DateTime.now();
      var ref = FirebaseStorage.instance.ref().child('test/$now.jpg');
      await ref.putFile(selectedImage!);
      print('Image uploaded successfully!');
    } else {
      print('No image selected.');
    }
  }
}
