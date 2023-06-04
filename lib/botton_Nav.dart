import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_now/Pages/chat.dart';
import 'package:trip_now/Pages/profile.dart';
import 'package:trip_now/Pages/wishlist.dart';
import 'Pages/home.dart';




class bottom_Nav extends StatefulWidget {
  const bottom_Nav({Key? key}) : super(key: key);

  @override
  State<bottom_Nav> createState() => _bottom_NavState();
}




class _bottom_NavState extends State<bottom_Nav> {
  int currentIndex = 0;

  final screens = [
    HomePage(),
    wishlist_page(),
    chat_page(),
    profile_page(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(

        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,

        onTap: (index) => setState(() => currentIndex = index),

        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Support',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
