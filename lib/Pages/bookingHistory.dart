

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../NavBar.dart';

class bookingHistory extends StatefulWidget {
  const bookingHistory({Key? key}) : super(key: key);

  @override
  State<bookingHistory> createState() => _bookingHistoryState();
}

class _bookingHistoryState extends State<bookingHistory> {

  var user = FirebaseAuth.instance.currentUser!;

  CollectionReference ref = FirebaseFirestore.instance.collection('Users');



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking History'),
      ),
      drawer: NavBar(),


      body: StreamBuilder(
        stream: ref.doc(user.uid).collection("Booking-Hotel-List").snapshots(),
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
                                Image.network(doc['Hotel Image'],
                                    height: 200, width: 395, fit: BoxFit.cover),
                                Text(
                                  doc['Hotel name'],
                                  style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  doc['Date'],
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
            return Text('No data available !',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold));
        },
      ),




    );
  }
}
