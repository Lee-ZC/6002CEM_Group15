

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  //const DetailPage({Key? key}) : super(key: key);

  final DocumentSnapshot post;

  DetailPage({ required this.post});


  @override
  State<DetailPage> createState() => _DetailPageState();
}



class _DetailPageState extends State<DetailPage> {


  final user = FirebaseAuth.instance.currentUser!;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Now'),
      ),

      body: Container(
        child: Card(
          margin: EdgeInsets.all(8.0),
          elevation: 10.0,
          color: Colors.deepOrangeAccent.shade100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Image.network(widget.post['ImageUrl'],
                        height: 200, width: 395, fit: BoxFit.cover),
                    Text(widget.post["Description"]),
                    Text(widget.post["Price"]),

                    ButtonBar(
                      children: <Widget>[
                        ElevatedButton(
                          child: Icon(
                            Icons.favorite_outlined,
                            // color: Colors.pink,
                            size: 24.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                          onPressed: (){},
                        ),
                        ElevatedButton(
                          child: Text("Book Now"),
                          onPressed: (){},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
        ),
      ),


    );

  }
}
