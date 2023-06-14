
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_now/Pages/bookingHistory.dart';
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

  var user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {

    var name="";

    CollectionReference collection = FirebaseFirestore.instance.collection('Users') as CollectionReference<Object?>;

    return     FutureBuilder<DocumentSnapshot>(
      //Fetching data from the documentId specified of the student
      future: collection.doc(FirebaseAuth.instance.currentUser!.uid ).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //Error Handling conditions
        if (snapshot.hasError) {
          print("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("Document does not exist");
        }

        //Data is output to the user
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          name=data['name'];
        }
        return Align(

          alignment: Alignment.topLeft,
          widthFactor: 0.7,
          child: Drawer(
            child: ListView(
              // Remove padding
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(name),
                  accountEmail: Text(user.email!),
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
                  leading: Icon(Icons.history),
                  title: Text('Booking History'),
                  onTap: () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>bookingHistory())),
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
      },

    );

  }
}