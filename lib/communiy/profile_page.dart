import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dementia/communiy/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.email, required this.userName})
      : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  File? _image; // Make _image nullable
  final picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadProfilePicture() async {
    try {
      if (_image != null) {
        String userId = _auth.currentUser!.uid;
        Reference ref = _storage.ref().child('profile_pictures/$userId.jpg');
        await ref.putFile(_image!);
        String imageUrl = await ref.getDownloadURL();

        // TODO: Update the user's profile in Firebase with the imageUrl
        // For example, you can use Firestore to store user data including the profile picture URL.
        FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({'profilePicture': imageUrl});

        // Display a success message or update UI accordingly.
        print('Profile picture uploaded successfully!');
      } else {
        // Handle case where no image is selected.
        print('No image selected');
      }
    } catch (e) {
      // Handle errors during the upload process.
      print('Error uploading profile picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text(
          "Profile",
          style: TextStyle(
              color: Colors.white, fontSize: 27, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onDoubleTap: () async {
                _getImageFromGallery();
              },
              child: Icon(
                Icons.account_circle,
                size: 200,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Full Name", style: TextStyle(fontSize: 17)),
                Text(widget.userName, style: const TextStyle(fontSize: 17)),
              ],
            ),
            const Divider(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Email", style: TextStyle(fontSize: 17)),
                Text(widget.email, style: const TextStyle(fontSize: 17)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
