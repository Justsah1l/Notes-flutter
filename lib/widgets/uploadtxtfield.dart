import 'package:flutter/material.dart';

class Uploadtxt extends StatefulWidget {
  String? lable;
  Icon icon;
  TextEditingController controller = TextEditingController();
  Uploadtxt(
      {super.key,
      required this.lable,
      required this.controller,
      required this.icon});

  @override
  State<Uploadtxt> createState() => _UploadtxtState();
}

class _UploadtxtState extends State<Uploadtxt> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.lable,
          labelStyle: TextStyle(fontWeight: FontWeight.bold),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.black, width: 20)),
          suffixIcon: widget.icon,
        ),
      ),
    );
  }
}
