


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../NavBar.dart';

class wishlist_page extends StatefulWidget {
  const wishlist_page({Key? key}) : super(key: key);

  @override
  State<wishlist_page> createState() => _wishlist_pageState();
}

class _wishlist_pageState extends State<wishlist_page> {

  var user = FirebaseAuth.instance.currentUser!;

  CollectionReference ref = FirebaseFirestore.instance.collection('user-favourite-hotels');


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text('Trip Now'),
      ),
      drawer: NavBar(),

      body: StreamBuilder(
        stream: ref.doc(user.uid).collection("hotels").snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  dynamic doc = snapshot.data!.docs[index].data();

                  return SizedBox(
                    height: 335.0,
                    child: Card(
                        margin: EdgeInsets.all(8.0),
                        elevation: 10.0,
                        color: Colors.blueAccent.shade100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Image.network(doc['ImageUrl'],
                                    height: 200, width: 395, fit: BoxFit.cover),
                                Text(
                                  doc['Hotel name'],
                                  style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  doc['Price'],
                                  style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                  );


                });
          } else
            return Center( child: Text('No data available !',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)));
        },
      ),





      
    );
  }
}
