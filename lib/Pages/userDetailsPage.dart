import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_now/Pages/editProfilePage.dart';
import 'package:trip_now/database.dart';

import '../NavBar.dart';
import '../sign_up.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  final user = FirebaseAuth.instance.currentUser!;
  var name = "";
  var email = "";
  var uid = "";
  bool edit = false;


  @override
  Widget build(BuildContext context) {
    void fetchData()  {
      DatabaseService.getUserName(FirebaseAuth.instance.currentUser!.uid)
          .then((result) {
        setState(() {
          name = result!;
        });
      });
      DatabaseService.getEmail(FirebaseAuth.instance.currentUser!.uid)
          .then((result) {
        setState(() {
          email = result!;
        });
      });
      uid=FirebaseAuth.instance.currentUser!.uid;
    }

    fetchData();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Trip Now'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 100,
                              ),
                              radius: 80,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "User ID",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 50,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          uid,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Name",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 50,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          name,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Email",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(
                      height: 50,
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          email,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Container(
                        height: 80,
                        width: 150,
                        padding: const EdgeInsets.all(20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text('Edit'),
                          onPressed: () { Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => EditProfilePage()));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }

  }


