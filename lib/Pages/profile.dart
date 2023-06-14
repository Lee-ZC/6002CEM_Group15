import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_now/Pages/FAQPage.dart';
import 'package:trip_now/Pages/userDetailsPage.dart';
import 'package:trip_now/database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../NavBar.dart';

class profile_page extends StatefulWidget {
  const profile_page({Key? key}) : super(key: key);

  @override
  State<profile_page> createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  final user = FirebaseAuth.instance.currentUser!;
  var name="";
  CollectionReference collection = FirebaseFirestore.instance
      .collection('Users') as CollectionReference<Object?>;

  @override
  Widget build(BuildContext context) {
    void fetchData()  {
      DatabaseService.getUserName(FirebaseAuth.instance.currentUser!.uid)
          .then((result) {
        setState(() {
          name = result!;
        });
      });
    }
    fetchData();
        return Scaffold(
          appBar: AppBar(
            title: const Text('Trip Now'),
          ),
          drawer: const NavBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Stack(
                            children: const [
                              CircleAvatar(
                                radius: 80,
                                child: Icon(
                                  Icons.person,
                                  size: 100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        name,
                        style:
                            const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: const [
                      Text(
                        'Settings',
                        style:
                            TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const UserDetailsPage()));
                  },
                  child: Container(
                    height: 50,
                    child: const ListTile(
                      leading: CircleAvatar(
                        child: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 50,
                      ),
                      title: Text(
                        "Edit Profile",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    Future <void> launchWhatsApp() async {
                      final String phoneNumber = '60124596889';
                      Uri url = Uri.parse('https://api.whatsapp.com/send/?phone=60124596889&text&type=phone_number&app_absent=0');
                      if (!await launchUrl(launchUrl(Uri.parse('https://wa.me/$phoneNumber?text=Hi, I need help.'),
                          mode: LaunchMode.externalApplication) as Uri)) {
                        throw Exception('Could not launch $url');
                      }
                    }

                    launchWhatsApp();
                    },
                  child: Container(
                    height: 50,
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.chat,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 50,
                      ),
                      title: Text(
                        "Customer Support",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>FAQPage()));

                  },
                  child: Container(
                    height: 50,
                    child: const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.question_mark,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_right,
                        size: 50,
                      ),
                      title: Text(
                        "Help Center",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50,),
                Center(
                  child: Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                      },
                      child: const Text('Log out'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }

  }

