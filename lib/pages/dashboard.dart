import 'package:flutter/material.dart';
import 'package:fe_customcrew/pages/home/home.dart';


class Dasboard extends StatelessWidget {
  Dasboard({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}
