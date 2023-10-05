import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/neopop.dart';
import 'colors.dart';
import './widgets/notesmain.dart';

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notes",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Lottie.asset("images/front.json"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                "All handouts at",
                style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold, fontSize: 45),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                "one place",
                style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold, fontSize: 38),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: Text(
                "Get the notes and handouts you like or contribute by uploading your own notes for others.",
                style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: NeoPopTiltedButton(
                isFloating: true,
                onTapUp: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const notesmain()));
                },
                decoration: const NeoPopTiltedButtonDecoration(
                  color: Color.fromRGBO(255, 235, 52, 1),
                  plunkColor: Color.fromRGBO(255, 235, 52, 1),
                  shadowColor: Color.fromARGB(255, 0, 0, 0),
                  showShimmer: false,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 120.0,
                    vertical: 5,
                  ),
                  child: Text('Get Started',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
