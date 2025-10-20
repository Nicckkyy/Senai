import 'package:flutter/material.dart';

class Tela2 extends StatefulWidget {
  const Tela2({super.key});

  @override
  State<Tela2> createState() => _Tela2State();
}

class _Tela2State extends State<Tela2> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Container(
              width: screenWidth,
              child: Image.asset('assets/arriety.jpg', fit: BoxFit.cover),
            ),
            Container(
              width: screenWidth,
              child: Image.asset('assets/totoro.jpg', fit: BoxFit.cover),
            ),
            Container(
              width: screenWidth,
              child: Image.asset('assets/arriety.jpg', fit: BoxFit.cover),
            ),
            Container(
              width: screenWidth,
              child: Image.asset('assets/totoro.jpg', fit: BoxFit.cover),
            ),
          ],
        ),
      ),
    );
  }
}
