import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/colors.dart';
import 'package:notes/widgets/fetch.dart';
import 'package:notes/widgets/pdfview.dart';
import 'package:notes/widgets/uploadpage.dart';
import 'package:neopop/neopop.dart';

class notesmain extends StatefulWidget {
  const notesmain({super.key});

  @override
  State<notesmain> createState() => _notesmainState();
}

class _notesmainState extends State<notesmain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Notes",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          leading: FloatingActionButton(
              elevation: 0,
              backgroundColor: Pallete.whiteColor,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_new)),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('images/main.json'),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Simply upload your well-crafted study notes to share with fellow students or browse and download notes shared by others to excel in your studies",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NeoPopButton(
                    color: Color.fromRGBO(255, 235, 52, 1),
                    onTapUp: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Uploadpage()));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Upload",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  NeoPopButton(
                    color: Color.fromRGBO(255, 235, 52, 1),
                    onTapUp: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Fetch()));
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Browse",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
