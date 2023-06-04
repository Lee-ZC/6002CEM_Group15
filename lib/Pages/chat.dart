


import 'package:flutter/material.dart';

import '../NavBar.dart';

class chat_page extends StatefulWidget {
  const chat_page({Key? key}) : super(key: key);

  @override
  State<chat_page> createState() => _chat_pageState();
}

class _chat_pageState extends State<chat_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Trip Now'),
      ),
      drawer: NavBar(),
      body: Center(
        child: Text(
          'Chat',style: TextStyle(fontSize: 60),
        ),
      ),


    );
  }
}
