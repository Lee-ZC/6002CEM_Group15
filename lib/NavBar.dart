
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_now/Pages/chat.dart';
import 'package:trip_now/Pages/home.dart';
import 'package:trip_now/Pages/profile.dart';
import 'package:trip_now/Pages/wishlist.dart';
import 'main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_now/model/user.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowMaterialGrid: false,
      debugShowCheckedModeBanner: false,
      home: NBPage(),
    );
  }
}

class NBPage extends StatefulWidget {
  const NBPage({Key? key}) : super(key: key);

  @override
  _NBState createState() => _NBState();
}

class _NBState extends State<NBPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      widthFactor: 0.7,
      child: Drawer(
        child: ListView(
          // Remove padding
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(user.displayName.toString()),
              accountEmail: Text(user.email!),
              // currentAccountPicture: CircleAvatar(
              //   child: ClipOval(
              //     child: Image.network(
              //       getUserInfo().getUImg().toString(),
              //       fit: BoxFit.cover,
              //       width: 90,
              //       height: 90,
              //     ),
              //   ),
              // ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
              ),
            ),
            ListTile(
              leading: Icon(Icons.explore),
              title: Text('Explore'),
              onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomePage())),
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('WishList'),
              onTap: ()=>Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>wishlist_page())),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Customer Support'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>chat_page())),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>profile_page())),
            ),
            Divider(),
            // ListTile(
            //   title: Text('Settings'),
            //   leading: Icon(Icons.settings),
            //   onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>Setting())),
            // ),
          ],
        ),
      ),
    );
  }
}