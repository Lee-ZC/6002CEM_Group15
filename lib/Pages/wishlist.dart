


import 'package:flutter/material.dart';

import '../NavBar.dart';

class wishlist_page extends StatefulWidget {
  const wishlist_page({Key? key}) : super(key: key);

  @override
  State<wishlist_page> createState() => _wishlist_pageState();
}

class _wishlist_pageState extends State<wishlist_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Trip Now'),
      ),
      drawer: NavBar(),
      body: Center(
        child: Text(
          'wishList',style: TextStyle(fontSize: 60),
        ),
      ),

      
    );
  }
}
