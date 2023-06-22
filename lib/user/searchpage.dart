import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devu/about.dart';
import 'package:devu/firebase/auth_services.dart';
import 'package:devu/loginandsignup/filestorage.dart';
import 'package:devu/loginandsignup/login.dart';
import 'package:devu/user/booknow.dart';
import 'package:devu/user/editprofileuser.dart';
import 'package:devu/user/mybookings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'bookticket.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SecureStorage secureStorage = SecureStorage();
  String email = "";
  String name = "";
  String fieldname = "";
  String Location = "";
  String facilities = "";
  String capacity = "";
  String rentalCharge = "";
  String phone = "";
  String address = "";
  String image = "";
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
  void initState() {
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
      image = (snap.data() as Map<String, dynamic>)['stadiumImage'];
      email = (snap.data() as Map<String, dynamic>)['email'];
      name = (snap.data() as Map<String, dynamic>)['username'];

      phone = (snap.data() as Map<String, dynamic>)['phone'];
    });
  }

  bool isSearching = false;
  List<String> nameCheck = [];
  List<String> nameList = [];
  final TextEditingController _textEditingController = TextEditingController();

  final List<String> _dataList = [];
  final List<String> _searchResult = [];

  final TextEditingController _searchController = TextEditingController();
  String? valuechoose;
  final List<String> selectList = [
    'Thiruvananthapuram',
    'Kollam',
    'Pathanamthitta',
    'Alappuzha',
    'Kottayam',
    'Ernakulam',
    'Idukki',
    'Malappuram',
    'Kozhikode',
    'Kannur',
    'Palakkad',
    'Thrissur',
    'Kasaragod'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.black,
          title: const Text('ARENA')),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              accountName: Text(
                name.toUpperCase(),
                style:
                    const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              ),
              accountEmail: Text(email),
              currentAccountPicture: Row(
                children: [
                  const SizedBox(
                    width: 0,
                  ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(image),
                    radius: 36,
                  ),
                ],
              ),
            ),
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
            // ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('EDIT PROFILE'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileUser()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_online),
              title: const Text('MY BOOKINGS'),
              onTap: () {
                Navigator.pop(context); // close the drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Mybookingscreen()),
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
                secureStorage.deleteSecureData('email');
                secureStorage.deleteSecureData("Role");
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: DropdownButtonFormField(
                  hint: const Text(
                    'Search by District',
                    style: TextStyle(fontSize: 15),
                  ),
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
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Expanded(
              child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('owners')
                .where(
                  'District',
                  isEqualTo: valuechoose,
                )
                .get(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: (snapshot.data! as dynamic).docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        name = (snapshot.data! as dynamic).docs[index]['Stadium Name'];
                        //superid = (snapshot.data! as dynamic).docs[index]['uid'];
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (ctx) => Bookticket(
                        //         name: (snapshot.data! as dynamic).docs[index]
                        //             ['Stadium Name']),
                        //   ),
                        // );
                         Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => BookNowPage(
                                name: (snapshot.data! as dynamic).docs[index]
                                    ['Stadium Name'],image: (snapshot.data! as dynamic).docs[index]
                                    ['stadiumImage'],),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          StadiumCard(
                              name: (snapshot.data! as dynamic)
                                  .docs[index]['Stadium Name']
                                  .toString(),
                              details: (snapshot.data! as dynamic)
                                  .docs[index]['Rental Charges']
                                  .toString(),
                              image: (snapshot.data! as dynamic).docs[index]
                                  ['imageLink']),
                          const SizedBox(
                            height: 15,
                          )
                        ],
                      )
                      // ListTile(
                      //   leading: (snapshot.data! as dynamic).docs[index]
                      //               ['imageLink'] ==
                      //           null
                      //       ? const CircleAvatar(
                      //           backgroundImage: NetworkImage('image/png;base64,'),
                      //           radius: 16,
                      //         )
                      //       : CircleAvatar(
                      //           backgroundImage: NetworkImage(
                      //             (snapshot.data! as dynamic).docs[index]
                      //                 ['imageLink'],
                      //           ),
                      //           radius: 16,
                      //         ),
                      //   title: Text(
                      //     (snapshot.data! as dynamic)
                      //         .docs[index]['Stadium Name']
                      //         .toString()
                      //         .toUpperCase(),
                      //   ),
                      // ),
                      );
                },
              );
            },
          )),
        ],
      ),
    );
  }

  void onSearchTextChanged(String text) {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    for (var item in _dataList) {
      if (item.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(item);
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}

class UserBox extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  const UserBox({
    Key? key,
    required this.name,
    required this.email,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6.0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text('Email: $email'),
          Text('Phone: $phone'),
        ],
      ),
    );
  }
}

class SportsNewsWidget extends StatelessWidget {
  const SportsNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          SportsNewsItem(
            imageUrl: 'https://example.com/image1.jpg',
            title: 'Sports News 1',
          ),
          SportsNewsItem(
            imageUrl: 'https://example.com/image2.jpg',
            title: 'Sports News 2',
          ),
          SportsNewsItem(
            imageUrl: 'https://example.com/image3.jpg',
            title: 'Sports News 3',
          ),
          // Add more SportsNewsItem widgets here as needed
        ],
      ),
    );
  }
}

class SportsNewsItem extends StatelessWidget {
  final String imageUrl;
  final String title;

  const SportsNewsItem({
    Key? key,
    required this.imageUrl,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SearchScreen(),
  ));
}

class StadiumCard extends StatelessWidget {
  final String name;
  final String details;
  final String image;

  const StadiumCard({
    super.key,
    required this.name,
    required this.details,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(0, 2),
            blurRadius: 4.0,
          ),
        ],
      ),
      child: Card(
        elevation: 0.0, // Set elevation to 0 to prevent double shadows
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                image,
                fit: BoxFit.cover,
                height: 200.0,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      details,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
