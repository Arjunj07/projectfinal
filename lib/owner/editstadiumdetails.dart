import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devu/owner/bookingrequests.dart';
import 'package:devu/resources/store.dart';
import 'package:devu/resources/storepic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/utils.dart';

class ProfileNewInfo extends StatefulWidget {
  const ProfileNewInfo({super.key});

  @override
  State<ProfileNewInfo> createState() => _ProfileNewInfoState();
}

class _ProfileNewInfoState extends State<ProfileNewInfo> {
  // TextEditingController namecontrolller = TextEditingController();
  // TextEditingController phonecontrolller = TextEditingController();
  // TextEditingController emailcontrolller = TextEditingController();
  TextEditingController addresscontrolller = TextEditingController();
  TextEditingController facilitiescontrolller = TextEditingController();
  // TextEditingController aboutmecontrolller = TextEditingController();
  TextEditingController rentalcontrolller = TextEditingController();
  TextEditingController stadiumcontrolller = TextEditingController();
  TextEditingController capacitycontrolller = TextEditingController();
  TextEditingController districtcontroller = TextEditingController();

  // String email = "";
  // String name = "";
  // String Aboutme = "";
  String stadium = "";
  String Address = "";
  String capacity = "";
  String rentalCharge = "";
  // String phone = "";
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
      // emailcontrolller.text = (snap.data() as Map<String, dynamic>)['email'];
      // namecontrolller.text = (snap.data() as Map<String, dynamic>)['username'];
      // aboutmecontrolller.text =
      //     (snap.data() as Map<String, dynamic>)['About me'];
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
      valuechoose = (snap.data() as Map<String, dynamic>)['District'];
      // phonecontrolller.text = (snap.data() as Map<String, dynamic>)['phone'];
    });
  }

  void saveprofile() async {
    String resp = await Storedata().addImage(file: _image!);
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

  void saveprofile1() async {
    String resp = await Storepicdata().addImage(file: _image!);
  }

  final storage1 = FirebaseStorage.instance;

  // getdata1() async {
  //   DocumentSnapshot snap = await FirebaseFirestore.instance
  //       .collection('owners')
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .get();
  //   setState(() {
  //     image = (snap.data() as Map<String, dynamic>)['imageLink1'];
  //   });
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getname();
    getdata();
  }

  String? valuechoose;
  final List<String> selectList = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alapuzha',
    'Kottayam',
    'Ernakulam',
    'Idukki',
    'Malapuram',
    'Kozhikode',
    'Kannur',
    'Palakkad',
    'Thrissur',
    'Kasargod'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Stadium Details',
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
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    //
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
                    const SizedBox(height: 10),
                    TextFormField(
                      minLines: 1,
                      maxLines: 3,
                      controller: addresscontrolller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.home,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('Address'),
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
                    DropdownButtonFormField(
                        hint: const Text('Select District'),
                        style: const TextStyle(color: Colors.black),
                        itemHeight: 50,
                        decoration: const InputDecoration(
                          focusedBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          // border: OutlineInputBorder(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(15))),
                          // enabledBorder: OutlineInputBorder(
                          //     borderRadius:
                          //         BorderRadius.all(Radius.circular(10))),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        focusColor: Colors.white,
                        value: valuechoose,
                        onTap: () {},
                        items: selectList
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            valuechoose = value as String;
                            print(valuechoose);
                          });
                        }),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: capacitycontrolller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.groups,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('Capacity'),
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
                      maxLines: 3,
                      controller: facilitiescontrolller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.forum,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('Facilities'),
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
                      maxLines: 3,
                      controller: rentalcontrolller,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.currency_rupee_sharp,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.all(14),
                          label: Text('Rental Charges'),
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
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          selectImage();
                        },
                        child: const Text('Upload pictures'))
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
                    saveprofile1();
                    FirebaseFirestore.instance
                        .collection('owners')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .update(
                      {
                        // "phone": phonecontrolller.text.trim(),
                        // "username": namecontrolller.text.trim(),
                        // "email": emailcontrolller.text.trim(),
                        // "About me": aboutmecontrolller.text.trim(),
                        "Stadium Name": stadiumcontrolller.text.trim(),
                        "Address": addresscontrolller.text.trim(),
                        "Capacity": capacitycontrolller.text.trim(),
                        "Facilities": facilitiescontrolller.text.trim(),
                        "Rental Charges": rentalcontrolller.text.trim(),
                        'District': valuechoose,
                        'owner-id': FirebaseAuth.instance.currentUser!.uid
                      },
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Bookingrequestscreen()),
                    );
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ));
  }
}
