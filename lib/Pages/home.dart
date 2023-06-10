import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_now/Pages/wishlist.dart';
import 'package:trip_now/botton_Nav.dart';

import '../NavBar.dart';
import '../model/hotel.dart';
import 'DetailPage.dart';
import 'chat.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {

  //List<HotelModel> hotelList = [];

  CollectionReference ref = FirebaseFirestore.instance.collection('hotels');


  navigateToDetail(DocumentSnapshot post){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailPage(post:post,)));
  }


  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(

      appBar: AppBar(
        title: const Text('Trip Now'),
      ),
      drawer: NavBar(),

      body: StreamBuilder(
        stream: ref.snapshots(),
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
                      color: Colors.deepOrangeAccent.shade100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            children: [
                              Image.network(doc['ImageUrl'],
                             height: 200, width: 395, fit: BoxFit.cover),
                              Text(
                                doc['name'],
                                style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "RM"+
                                doc['Price'] +" night",
                                style: TextStyle(color: Colors.black,fontSize: 20,overflow: TextOverflow.visible),
                              ),
                              ButtonBar(
                                children: <Widget>[
                                  ElevatedButton(
                                    child: Text("More Info"),
                                    onPressed: ()=>navigateToDetail(snapshot.data!.docs[index]),
                                  ),
                                ],
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
