import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devu/owner/editownerprofile.dart';
import 'package:devu/owner/history.dart';
import 'package:devu/owner/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../about.dart';
import '../firebase/auth_services.dart';
import '../loginandsignup/login.dart';

class Bookingrequestscreen extends StatefulWidget {
  const Bookingrequestscreen({super.key});

  @override
  State<Bookingrequestscreen> createState() => _BookingrequestscreenState();
}

class _BookingrequestscreenState extends State<Bookingrequestscreen> {
  @override
  confirmbooking(String id1, String id2) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('booking-data')
        .where('user-id', isEqualTo: id1).where('status',isEqualTo: 'pending')
        .get();
    String id = querySnapshot.docs[0].id;
    await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('booking-data')
        .doc(id)
        .update({'status': 'accepted'});
    setState(() {});
    QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(id1)
        .collection('booking-data')
        .where('stadium-id', isEqualTo: id2)
        .get();
    String mid = querySnapshot1.docs[0].id;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id1)
        .collection('booking-data')
        .doc(mid)
        .update({'status': 'accepted'});
  }

  cancelbooking(String id1, String id2) async {
    print(id1);
    print(id2);
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('booking-data')
        .where('uid', isEqualTo: id1)
        .get();
    String id = querySnapshot.docs[0].id;
    await FirebaseFirestore.instance
        .collection('owners')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('booking-data')
        .doc(id)
        .delete();
    setState(() {});
    QuerySnapshot querySnapshot1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(id2)
        .collection('booking-data')
        .where('stadium-id', isEqualTo: id1)
        .get();
    String mid = querySnapshot1.docs[0].id;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(id2)
        .collection('booking-data')
        .doc(mid)
        .delete();
  }

  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(backgroundColor: Colors.black,title: Text('ARENA'),), drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            
            // ListTile(
            //   leading: const Icon(Icons.home),
            //   title: const Text('HOME'),
            //   onTap: () {
            //     Navigator.pop(context); // close the drawer
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const SearchScreen()),
            //     );
            //   },
            // ),Conta
            Container(height: 60,),
                ListTile(
              leading: const Icon(Icons.person_4),
              title: const Text('MY PROFILE'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('EDIT PROFILE'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileInformation()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('HISTORY'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Historyscreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.group),
              title: const Text('ABOUT US'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutUs()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('LOGOUT'),
              onTap: () async {
                // secureStorage.deleteSecureData('email');
                // secureStorage.deleteSecureData("Role");
                final res = await AuthServices.signout();
                if (res == null) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: res));
                }
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [SizedBox(height: 15,),
          Text('Booking Requests',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          Divider(thickness: 0.6,color: Colors.black,),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('owners')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('booking-data')
                  .where('status', isEqualTo: 'pending')
                  .get(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(11),
                            color: Colors.black,
                          ),
                          // height: 150,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.person_rounded,
                                    size: 40,
                                  ),
                                  const SizedBox(
                                    width: 7,
                                  ),
                                  Text(
                                    'Name of User:' +
                                        (snapshot.data! as dynamic)
                                            .docs[index]['user-name']
                                            .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Time Slot:',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                              (snapshot.data! as dynamic)
                                                  .docs[index]['time'],
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ]),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      children: [
                                        Text('Date',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['date'],
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Divider(
                                height: 20,
                                thickness: 0.7,
                                color: Colors.grey,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceBetween,
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(left: 10.0),
                              //       child: Column(
                              //           crossAxisAlignment:
                              //               CrossAxisAlignment.start,
                              //           children: [
                              //             Text(
                              //               'Booking Date:',

                              //             ),
                              //             Text(
                              //               (snapshot.data! as dynamic)
                              //                   .docs[index]['booked-date'],

                              //             ),
                              //           ]),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(right: 8.0),
                              //       child: Column(
                              //         children: [
                              //           Text(
                              //             'Booking Time:',

                              //           ),
                              //           Text(
                              //             (snapshot.data! as dynamic)
                              //                 .docs[index]['time'],

                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        confirmbooking(
                                          (snapshot.data! as dynamic)
                                              .docs[index]['user-id'],
                                          (snapshot.data! as dynamic)
                                              .docs[index]['uid'],
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.blue),
                                      child: Text(
                                        'Accept',
                                      )),
                                  ElevatedButton(
                                      onPressed: () {
                                        cancelbooking(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['uid'],
                                            (snapshot.data! as dynamic)
                                                .docs[index]['user-id']
                                            // (snapshot.data! as dynamic)
                                            //     .docs[index]['time'],

                                            );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: Text('Decline',
                                          style:
                                              TextStyle(color: Colors.black)))

                                  //     icon: const Icon(Icons.cancel_rounded)),
                                ],
                              ),
                              // Visibility(
                              //   //visible: !visibility,
                              //   child: ElevatedButton(
                              //       onPressed: () {
                              //         completebooking(
                              //           (snapshot.data! as dynamic).docs[index]
                              //               ['user-name'],
                              //           (snapshot.data! as dynamic).docs[index]
                              //               ['servicetype'],
                              //           (snapshot.data! as dynamic).docs[index]
                              //               ['booked-date'],
                              //           (snapshot.data! as dynamic).docs[index]
                              //               ['time'],
                              //         );
                              //       },
                              //       style: ElevatedButton.styleFrom(
                              //           backgroundColor:
                              //               Color.fromARGB(255, 21, 112, 249)),
                              //       child: Text(
                              //         'Completed',
                              //         style: GoogleFonts.raleway(
                              //             fontWeight: FontWeight.bold,
                              //             color: Colors.white),
                              //       )),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 20,
                        ));
              },
            ),
          ),
          
        ],
      )),
    );
  }
}
