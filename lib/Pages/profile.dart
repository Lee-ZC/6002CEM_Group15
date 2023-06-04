


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../NavBar.dart';

class profile_page extends StatefulWidget {
  const profile_page({Key? key}) : super(key: key);

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Now'),
      ),
      drawer: NavBar(),
      body: Column(
        children: [
          Text(user.email!),
          ElevatedButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: const Text('Logout'),
          ),
        ],
      ),


    );
  }
}
