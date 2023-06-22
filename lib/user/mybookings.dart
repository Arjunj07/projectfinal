import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Mybookingscreen extends StatefulWidget {
  const Mybookingscreen({super.key});

  @override
  State<Mybookingscreen> createState() => _MybookingscreenState();
}

class _MybookingscreenState extends State<Mybookingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'MY BOOKINGS',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('booking-data')
                  .where('status', isEqualTo: 'accepted')
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
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  // const Icon(
                                  //   Icons.receipt,
                                  //   size: 40,
                                  //   color: Colors.white,
                                  // ),

                                  Text(
                                    '   Name of Stadium:${(snapshot.data! as dynamic).docs[index]['Stadium name']}',
                                    style: const TextStyle(color: Colors.white),
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
                                          const Text('Time Slot:',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                              (snapshot.data! as dynamic)
                                                  .docs[index]['time'],
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                        ]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      children: [
                                        const Text('Date',
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Text(
                                            (snapshot.data! as dynamic)
                                                .docs[index]['date'],
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        const Text('Status :Accepted',
                                            style:
                                                TextStyle(color: Colors.white))
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
                              const SizedBox(
                                height: 12,
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
                    separatorBuilder: (context, index) => const SizedBox(
                          height: 20,
                        ));
              },
            ),
          )
        ],
      )),
    );
  }
}
