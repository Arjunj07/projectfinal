import 'dart:async';
import 'package:devu/loginandsignup/filestorage.dart';
import 'package:devu/owner/editownerprofile.dart';
import 'package:devu/user/searchpage.dart';
import 'package:flutter/material.dart';
import 'package:devu/loginandsignup/login.dart';

String? finalEmail;
String? finalRole;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    secureStorage.readSecureData('email').then((value) {
      finalEmail = value;
    });
    secureStorage.readSecureData('role').then((value) {
      finalRole = value;
    });
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (finalEmail == null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else if (finalEmail != null && finalRole.toString() == "USER") {
        {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const SearchScreen()));
        }
      } else if (finalEmail != null && finalRole.toString() == "OWNER") {
        {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProfileInformation()));
        }
      }
    });
  }

  // ignore: non_constant_identifier_names
  Color TextColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
                color: Colors.black,
                height: MediaQuery.of(context).size.height,
                child: const Image(
                    image: AssetImage("assets/Arena 'IN (2).png")))));
  }
}
