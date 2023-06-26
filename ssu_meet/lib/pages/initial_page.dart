import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ssu_meet/pages/home_page.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            width: screenWidth,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(33, 139, 225, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                SizedBox(
                  width: 120,
                  height: 100,
                  child: Image(
                    image: AssetImage(
                      "assets/images/post-it.png",
                    ),
                  ),
                ),
                Text(
                  "슈밋",
                  style: TextStyle(
                    fontFamily: "Ongeul",
                    color: Colors.white,
                    fontSize: 50,
                  ),
                ),
                Text(
                  "포스트잇으로 정해지는 나의 인연",
                  style: TextStyle(
                    fontFamily: "Ongeul",
                    color: Colors.white70,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}