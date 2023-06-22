import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devu/firebase/auth_services.dart';
import 'package:devu/owner/editownerprofile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../loginandsignup/login.dart';

// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({super.key});

// @override
// class ProfileInfo extends StatefulWidget {
//   const ProfileInfo({super.key});

//   @override
//   State<ProfileInfo> createState() => _ProfileInfoState();
// }

// class _ProfileInfoState extends State<ProfileInfo> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // title: 'Profile',
//       // theme: ThemeData(
//       //   primarySwatch: Colors.blue,
//       // ),
//       home: ProfilePage(),
//     );
//   }
// }

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final storage = FirebaseStorage.instance;
  String image = "";
  String email = "";
  String aboutme = "";
  String phone = "";
  String stadium = "";
  String address = "";
  String capacity = "";
  String facilities = "";
  String rental = "";
  String name = "";

  getdata() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      image = (snap.data() as Map<String, dynamic>)['imageLink'];
    });
  }

  getname() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    setState(() {
      email = (snap.data() as Map<String, dynamic>)['email'];
      name = (snap.data() as Map<String, dynamic>)['username'];
      aboutme = (snap.data() as Map<String, dynamic>)['About me'];
      phone = (snap.data() as Map<String, dynamic>)['phone'];
      stadium = (snap.data() as Map<String, dynamic>)['Stadium Name'];
      address = (snap.data() as Map<String, dynamic>)['Address'];
      capacity = (snap.data() as Map<String, dynamic>)['Capacity'];
      facilities = (snap.data() as Map<String, dynamic>)['Facilities'];
      rental = (snap.data() as Map<String, dynamic>)['Rental Charges'];
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
          'Profile',
          style: TextStyle(
            color: Colors.white, // Set the heading text color
          ),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Navigator.push(
        //             context,
        //             MaterialPageRoute(
        //                 builder: (context) => const ProfileInformation()));
        //       },
        //       icon: const Icon(Icons.edit)),
        //   IconButton(
        //       onPressed: () async {
        //         final res = await AuthServices.signout();
        //         if (res == null) {
        //           Navigator.of(context).pushReplacement(MaterialPageRoute(
        //               builder: (context) => const LoginScreen()));
        //         } else {
        //           ScaffoldMessenger.of(context)
        //               .showSnackBar(SnackBar(content: res));
        //         }
        //       },
        //       icon: const Icon(Icons.logout))
        // ],
        centerTitle: true,
        backgroundColor: Colors.black, // Set the heading background color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover),
                  borderRadius: const BorderRadius.all(Radius.circular(100))),
            ),
            // Positioned(
            //     bottom: 0,
            //     right: 0,
            //     child: GestureDetector(
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const ProfileInfo()));
            //       },
            //       child: const CircleAvatar(
            //         radius: 18,
            //         backgroundColor: Colors.black,
            //         child: Icon(
            //           Icons.edit,
            //           color: Colors.white,
            //         ),
            //       ),
            //     )),
            const SizedBox(height: 10),
            Text(
              name.toUpperCase(),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            // const Text(
            //   'Owner of Stadiums',
            //   style: TextStyle(
            //     fontSize: 15,
            //     color: Colors.grey,
            //   ),
            // ),
            const SizedBox(height: 16.0),
            const Text(
              'About Me:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              aboutme,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Contact Information:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            // SizedBox(height: 16.0),
            // Text(
            //   'Address:',
            //   style: TextStyle(
            //     fontSize: 18,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 8.0),
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Phone: $phone',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Stadium Info:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Stadium Name:$stadium',
              style: const TextStyle(
                fontSize: 17,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Address: $address',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Capacity:$capacity',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            // const Text(
            //   'Owner: Government of Kerala',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            Text(
              'Facilities : $facilities',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Rental Charges/day:$rental ',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
