import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devu/resources/store.dart';
import 'package:devu/resources/utils.dart';
import 'package:devu/user/searchpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  TextEditingController namecontrolller = TextEditingController();
  TextEditingController phonecontrolller = TextEditingController();
  TextEditingController emailcontrolller = TextEditingController();
  Uint8List? _image;

  String image = "";
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
    getdata();
  }

  getname() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      image = (snap.data() as Map<String, dynamic>)['imageLink'];
      emailcontrolller.text = (snap.data() as Map<String, dynamic>)['email'];
      namecontrolller.text = (snap.data() as Map<String, dynamic>)['username'];
      phonecontrolller.text = (snap.data() as Map<String, dynamic>)['phone'];
    });
  }

  void saveprofile() async {
    String resp = await Storedata().addImage(file: _image!);
  }

  final storage = FirebaseStorage.instance;

  getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      image = (snap.data() as Map<String, dynamic>)['imageLink'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white, // Set the heading text color
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.black, // Set the heading background color
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Stack(
              children: [
                _image == null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(image), fit: BoxFit.cover),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(100))),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: MemoryImage(_image!),
                      ),
                Positioned(
                    top: 50,
                    left: 65,
                    child: IconButton(
                        onPressed: () async {
                          // ImagePicker imagePicker = ImagePicker();
                          // XFile? file = await imagePicker.pickImage(
                          //     source: ImageSource.gallery);
                          selectImage();
                        },
                        icon: const Icon(Icons.add_a_photo)))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: namecontrolller,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        isDense: true,
                        contentPadding: EdgeInsets.all(14),
                        label: Text('User Name'),
                        fillColor: Color.fromARGB(120, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 64, 116, 220))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 64, 116, 220)))),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: emailcontrolller,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        isDense: true,
                        contentPadding: EdgeInsets.all(14),
                        label: Text('Email'),
                        fillColor: Color.fromARGB(120, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 64, 116, 220))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 64, 116, 220)))),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: phonecontrolller,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        isDense: true,
                        contentPadding: EdgeInsets.all(14),
                        label: Text('Contact no.'),
                        fillColor: Color.fromARGB(120, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 255, 255))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 64, 116, 220))),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 64, 116, 220)))),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.black), // Set the desired color
                ),
                onPressed: () {
                  saveprofile();
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update(
                    {
                      "phone": phonecontrolller.text.trim(),
                      "username": namecontrolller.text.trim(),
                      "email": emailcontrolller.text.trim(),
                    },
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()),
                  );
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
