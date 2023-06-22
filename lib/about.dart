import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            color: Colors.black, // Change the color here
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('About Us'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Welcome to Our App!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 18),
                Text(
                  'Our app is your ultimate companion for locating nearby play fields and stadiums. Whether you\'re an athlete, a sports enthusiast, or a fan, our app helps you find the perfect venues to engage in your favorite sports activities or spectate thrilling matches.',
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 18),
                Text(
                    'With our user-friendly interface, you can easily search for play fields and stadiums based on your preferences. Our extensive database provides comprehensive information about each venue, including photos, amenities, opening hours, and user reviews, ensuring you make informed decisions.',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 18),
                Text(
                    'We are dedicated to providing accurate and up-to-date data by collaborating with local sports associations, venue owners, and communities. Our goal is to make sports accessible to everyone, regardless of their skill level or interests.',
                    style: TextStyle(fontSize: 15)),
                SizedBox(height: 18),
                Text(
                    'Join our vibrant community of sports lovers and start exploring the vast network of play fields and stadiums near you. Download our app now and embark on an exciting sports journey!',
                    style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
        ));
  }
}
