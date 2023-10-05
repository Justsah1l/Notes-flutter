import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loadingani extends StatefulWidget {
  const Loadingani({super.key});

  @override
  State<Loadingani> createState() => _LoadinganiState();
}

class _LoadinganiState extends State<Loadingani> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Lottie.asset('images/load.json'),
            Text(
              "Please wait , loading ...",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
