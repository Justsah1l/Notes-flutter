import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/colors.dart';
import 'uploadtxtfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Uploadpage extends StatefulWidget {
  const Uploadpage({super.key});

  @override
  State<Uploadpage> createState() => _UploadpageState();
}

class _UploadpageState extends State<Uploadpage>
    with SingleTickerProviderStateMixin {
  late AnimationController anicontrol;

  bool shouldshow = false;
  TextEditingController nameoffile = TextEditingController();
  TextEditingController year = TextEditingController();
  TextEditingController subject = TextEditingController();
  TextEditingController aothname = TextEditingController();

  final FirebaseFirestore _firebasefirestore = FirebaseFirestore.instance;

  Future<String> uppdf(String filen, File file) async {
    final ref = FirebaseStorage.instance.ref().child("pdfs/$filen.pdf");

    final upload = ref.putFile(file);

    await upload.whenComplete(() => {});

    final fileurl = await ref.getDownloadURL();

    return fileurl;
  }

  void pickfile() async {
    final pickedfile = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (pickedfile != null) {
      File file = File(pickedfile.files[0].path!);
      final filename = pickedfile.files[0].name;

      final downloadlink = await uppdf(filename, file);

      String authname = "author";
      if (aothname.text != null) {
        authname = aothname.text;
      }

      if (year.text == "1") {
        _firebasefirestore.collection("firstyear").add({
          "name": nameoffile.text,
          "year": year.text,
          "subject": subject.text,
          "authorname": authname,
          "link": downloadlink,
        });
      }

      _firebasefirestore.collection("pdfs").add({
        "name": nameoffile.text,
        "year": year.text,
        "subject": subject.text,
        "authorname": authname,
        "link": downloadlink,
      });

      print("pdf uploaded");
      ani();
      nameoffile.clear();
      year.clear();
      subject.clear();
      aothname.clear();
    }
  }

  void ani() {
    showDialog(
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 200, horizontal: 40),
            backgroundColor: Colors.white,
            content: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  'images/done.json',
                  repeat: false,
                ),
                Text(
                  "Uploaded Successfully",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
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
          body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Almost there !",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 35),
                      ),
                    ),
                  ),
                  Text(
                    "Lets add some details of your file before uploading",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Color.fromARGB(255, 225, 202, 0)),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Uploadtxt(
                    lable: "Name of pdf",
                    controller: nameoffile,
                    icon: Icon(Icons.book),
                  ),
                  Uploadtxt(
                    lable: "Year",
                    controller: year,
                    icon: Icon(Icons.calendar_today_rounded),
                  ),
                  Uploadtxt(
                    lable: "Subject",
                    controller: subject,
                    icon: Icon(Icons.subject),
                  ),
                  Uploadtxt(
                    lable: "Your name (optional)",
                    controller: aothname,
                    icon: Icon(Icons.person),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: ElevatedButton(
                      onPressed: () {
                        pickfile();
                      },
                      child: Text(
                        "Upload",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(500, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          foregroundColor: Color.fromARGB(255, 0, 0, 0),
                          backgroundColor: Color.fromRGBO(255, 235, 52, 1)),
                    ),
                  ),
                ], //Color.fromARGB(255, 191, 13, 222)
              ))),
    );
  }
}
