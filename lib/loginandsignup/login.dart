import 'package:devu/user/searchpage.dart';
import 'package:flutter/material.dart';

import '../firebase/auth_services.dart';
import '../owner/bookingrequests.dart';
import 'filestorage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SecureStorage secureStorage = SecureStorage();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   secureStorage.readSecureData('uploadStaff').then((value) {
  //     finalupdate = value;
  //   });
  // }

  _loginUser() async {
    String email = _usernameController.text.trim();
    String password = _passwordController.text.trim();
    String role = await AuthServices.login(email: email, password: password);

    if (role != "USER" && role != "OWNER") {
      print(role);

      return;
    }

    Widget? page;
    switch (role.toUpperCase()) {
      case 'USER':
        secureStorage.writeSecureData('email', email);
        secureStorage.writeSecureData('role', role);
        page = const SearchScreen();
        break;
      case 'OWNER':
        secureStorage.writeSecureData('email', email);
        secureStorage.writeSecureData('role', role);
        page = const Bookingrequestscreen();
        break;
      default:
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(role)));
    }
    if (page != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (ctx2) => page!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(),
            Container(
              padding: const EdgeInsets.only(left: 35, top: 150),
              child: const Text(
                'Welcome\nback !',
                style: TextStyle(
                    color: Color.fromARGB(255, 15, 127, 101),
                    fontSize: 33,
                    fontWeight: FontWeight.w700),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [
                        TextField(
                          controller: _usernameController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Email",
                              prefixIcon:
                                  const Icon(Icons.email, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          controller: _passwordController,
                          style: const TextStyle(),
                          obscureText: true,
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              hintText: "Password",
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.black),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Sign in',
                              style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700),
                            ),
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  const Color.fromARGB(255, 15, 127, 101),
                              child: IconButton(
                                  color: Colors.white54,
                                  onPressed: () {
                                    _loginUser();
                                  },
                                  icon: const Icon(
                                    Icons.arrow_forward,
                                  )),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'register');
                              },
                              style: const ButtonStyle(),
                              child: const Text(
                                'Sign up',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 15, 127, 101)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
