import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:notes/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/widgets/loadingani.dart';

class Pdfview extends StatefulWidget {
  final String link;
  const Pdfview({super.key, required this.link});

  @override
  State<Pdfview> createState() => _PdfviewState();
}

class _PdfviewState extends State<Pdfview> {
  PDFDocument? doc;

  void iniURL() async {
    doc = await PDFDocument.fromURL(widget.link);

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    iniURL();
    print("pdf url here - " + widget.link);
  }

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
        body: doc != null ? PDFViewer(document: doc!) : Loadingani());
  }
}
