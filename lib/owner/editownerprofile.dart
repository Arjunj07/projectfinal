import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devu/owner/editstadiumdetails.dart';
import 'package:devu/resources/storeo.dart';
import 'package:devu/resources/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileInformation extends StatefulWidget {
  const ProfileInformation({super.key});

  @override
  State<ProfileInformation> createState() => _ProfileInformationState();
}

class _ProfileInformationState extends State<ProfileInformation> {
  TextEditingController namecontrolller = TextEditingController();
  TextEditingController phonecontrolller = TextEditingController();
  TextEditingController emailcontrolller = TextEditingController();
  TextEditingController addresscontrolller = TextEditingController();
  TextEditingController facilitiescontrolller = TextEditingController();
  TextEditingController aboutmecontrolller = TextEditingController();
  TextEditingController rentalcontrolller = TextEditingController();
  TextEditingController stadiumcontrolller = TextEditingController();
  TextEditingController capacitycontrolller = TextEditingController();

  String email = "";
  String name = "";
  String Aboutme = "";
  String stadium = "";
  String Address = "";
  String capacity = "";
  String rentalCharge = "";
  String phone = "";
  String facilities = "";
  Uint8List? _image;

  String image = "";
  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  getname() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      emailcontrolller.text = (snap.data() as Map<String, dynamic>)['email'];
      namecontrolller.text = (snap.data() as Map<String, dynamic>)['username'];
      aboutmecontrolller.text =
          (snap.data() as Map<String, dynamic>)['About me'];
      stadiumcontrolller.text =
          (snap.data() as Map<String, dynamic>)['Stadium Name'];
      addresscontrolller.text =
          (snap.data() as Map<String, dynamic>)['Address'];
      capacitycontrolller.text =
          (snap.data() as Map<String, dynamic>)['Capacity'];
      facilitiescontrolller.text =
          (snap.data() as Map<String, dynamic>)['Facilities'];
      rentalcontrolller.text =
          (snap.data() as Map<String, dynamic>)['Rental Charges'];
      phonecontrolller.text = (snap.data() as Map<String, dynamic>)['phone'];
    });
  }

  void saveprofile() async {
    String resp = await Storedata1().addImage(file: _image!);
  }

  final storage = FirebaseStorage.instance;

  getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      image = (snap.data() as Map<String, dynamic>)['imageLink'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.white, // Set the heading text color
            ),
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
                height: 10,
              ),
              Stack(
                children: [
                  _image == null
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(image),
                                  fit: BoxFit.cover),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100))),
                        )
                      : CircleAvatar(
                          radius: 45,
                          backgroundImage: MemoryImage(_image!),
                        ),
                  Positioned(
                      top: 50,
                      left: 55,
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                      minLines: 1,
                      maxLines: 4,
                      controller: aboutmecontrolller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.comment,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('About Me'),
                          fillColor: Color.fromARGB(120, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                          prefixIcon: Icon(
                            Icons.phone,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('Contact no.'),
                          fillColor: Color.fromARGB(120, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                          prefixIcon: Icon(
                            Icons.email,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('Email'),
                          fillColor: Color.fromARGB(120, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
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
                      controller: stadiumcontrolller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.business,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('Stadium Name'),
                          fillColor: Color.fromARGB(120, 255, 255, 255),
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 255, 255, 255))),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 64, 116, 220))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 64, 116, 220)))),
                    ),
                    //
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
                        .collection('owners')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update(
                      {
                        // "imageLink":image,
                        "phone": phonecontrolller.text.trim(),
                        "username": namecontrolller.text.trim(),
                        "email": emailcontrolller.text.trim(),
                        "About me": aboutmecontrolller.text.trim(),
                        "Stadium Name": stadiumcontrolller.text.trim(),
                        "Address": addresscontrolller.text.trim(),
                        "Capacity": capacitycontrolller.text.trim(),
                        "Facilities": facilitiescontrolller.text.trim(),
                        "Rental Charges": rentalcontrolller.text.trim()
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileNewInfo()),
                    );
                  },
                  child: const Text('NEXT'),
                ),
              ),
            ],
          ),
        ));
  }
}
