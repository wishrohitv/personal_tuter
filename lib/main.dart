import 'package:flutter/material.dart';
import 'package:project_tuter/screens/tuter_screen.dart';


void main(){
  runApp(MainUI());
}


class MainUI extends StatelessWidget {
  const MainUI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Project Tuter",
      home: TuterScreen(),
    );
  }
}