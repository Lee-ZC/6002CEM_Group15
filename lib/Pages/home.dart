import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_now/Pages/wishlist.dart';
import 'package:trip_now/botton_Nav.dart';

import '../NavBar.dart';
import 'chat.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;


    return Scaffold(

      appBar: AppBar(
        title: const Text('Trip Now'),
      ),
      drawer: NavBar(),




      body: Column(
        children: [
          Text("Home"),
        ],
      ),



    );
  }
}
