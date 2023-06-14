import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trip_now/Pages/wishlist.dart';

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
  CollectionReference ref = FirebaseFirestore.instance.collection('hotels');
  TextEditingController searchController = TextEditingController();
  List<DocumentSnapshot>? snapshotData;
  List<DocumentSnapshot> filteredData = [];

  navigateToDetail(DocumentSnapshot post) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailPage(post: post)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Now'),
      ),
      drawer: NavBar(),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                setState(() {
                  filteredData = _filterData(value);
                });
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ref.snapshots(),
              builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  snapshotData = snapshot.data!.docs;
                  if (filteredData.isEmpty) {
                    filteredData = snapshotData!;
                  }
                  return ListView.builder(
                    itemCount: filteredData.length,
                    itemBuilder: (context, index) {
                      dynamic doc = filteredData[index].data();
                      return SizedBox(
                        height: 335.0,
                        child: Card(
                          margin: EdgeInsets.all(8.0),
                          elevation: 10.0,
                          color: Colors.deepOrangeAccent.shade100,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16.0),
                                    bottomLeft: Radius.circular(16.0),
                                  ),
                                  child: Image.network(
                                    doc['ImageUrl'],
                                    height: 335,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doc['name'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        "RM ${doc['Price']} per night",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                      Spacer(),
                                      ElevatedButton(
                                        onPressed: () =>
                                            navigateToDetail(filteredData[index]),
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 20),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                        ),
                                        child: Text(
                                          "More Info",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Text(
                    'No data available!',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }


  List<DocumentSnapshot> _filterData(String searchQuery) {
    if (searchQuery.isEmpty) {
      return snapshotData ?? [];
    }
    return snapshotData!.where((doc) {
      dynamic hotelName = (doc?.data() as Map<String, dynamic>)?['name'];
      dynamic hotelLocation = (doc?.data() as Map<String, dynamic>)?['Location'];

      String hotelNameWithLocation = '$hotelName $hotelLocation';
      return hotelNameWithLocation.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }



}