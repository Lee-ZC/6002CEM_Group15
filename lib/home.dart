import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final user=FirebaseAuth.instance.currentUser!;
    return Scaffold(
      appBar: AppBar(title: const Text('Trip Now'),),
      body: Column(
        children: [
          Text(user.email!),
          ElevatedButton(onPressed: (){FirebaseAuth.instance.signOut();}, child: const Text('Logout'),),
        ],
      ),
    );
  }
}
