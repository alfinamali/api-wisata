import 'dart:async';

import 'package:flutter/material.dart';
import 'package:SM1/Screens/login_screen.dart';
// import 'package:SM1/login_register/login.dart';
import 'package:SM1/pages/home.dart';

class StartedPage extends StatefulWidget {
  const StartedPage({Key? key}) : super(key: key);

  @override
  State<StartedPage> createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 140, 205, 254),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 70,
            ),
            Container(
              height: size.height / 1.8,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Image.asset(
                "assets/image/su.png",
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "All tours in one app",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      right: 100,
                    ),
                    child: Text(
                      "Find interesting and most popular tourist spots",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  // InkWell(
                  //   onTap: () => Navigator.push(context,
                  //       MaterialPageRoute(builder: (context) {
                  //     return HomePage();
                  //   })),
                  //   child: Container(
                  //     height: 56,
                  //     decoration: BoxDecoration(
                  //       color: Colors.lightBlue,
                  //       borderRadius: BorderRadius.circular(16),
                  //     ),
                  //     child: const Center(
                  //       child: Text(
                  //         "Get Started",
                  //         style: TextStyle(
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 16,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
