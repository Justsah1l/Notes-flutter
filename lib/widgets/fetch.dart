import 'package:flutter/material.dart';
import 'package:notes/colors.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes/widgets/loadingani.dart';
import 'package:notes/widgets/pdfview.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class Fetch extends StatefulWidget {
  const Fetch({super.key});

  @override
  State<Fetch> createState() => _FetchState();
}

class _FetchState extends State<Fetch> {
  bool viewingppt = false;
  var collec = FirebaseFirestore.instance.collection("pdfs");
  late List<Map<String, dynamic>> items;
  bool havedata = false;
  bool toshowdownloadindicator = false;

  _incoun() async {
    List<Map<String, dynamic>> templist = [];
    var data = await collec.get();

    data.docs.forEach((element) {
      templist.add(element.data());
    });

    setState(() {
      items = templist;
      havedata = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _incoun();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
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
              child: viewingppt
                  ? Icon(Icons.close)
                  : Icon(Icons.arrow_back_ios_new)),
        ),
        body: Center(
          child: havedata
              ? ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(width: 5),
                            borderRadius: BorderRadius.circular(10)),
                        leading: Icon(
                          Icons.library_books_rounded,
                          size: 30,
                        ),
                        title: Text(
                          items[index]["name"] ?? "Not provided",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Subject - ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  items[index]["subject"] ?? "Not provided",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Author - ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  items[index]["authorname"] ?? "Not provided",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.download,
                            size: 30,
                          ),
                          onPressed: () {
                            FileDownloader.downloadFile(
                              url: items[index]["link"],
                              onProgress: (name, progress) {
                                setState(() {
                                  toshowdownloadindicator = true;
                                });
                              },
                              onDownloadCompleted: (path) {
                                setState(() {
                                  toshowdownloadindicator = false;
                                });
                              },
                            );
                          },
                        ),
                        onTap: () {
                          setState(() {
                            viewingppt = true;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Pdfview(
                                        link: items[index]["link"],
                                      )));
                        },
                      ),
                    );
                  })
              : Loadingani(),
        ));
  }
}
