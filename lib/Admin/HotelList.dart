import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_now/Admin/Manage_Hotel.dart';

class hotelList extends StatefulWidget {
  const hotelList({Key? key}) : super(key: key);

  @override
  State<hotelList> createState() => _hotelListState();
}

class _hotelListState extends State<hotelList> {
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  _buildTextField(TextEditingController controller, String labelText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: secondaryColor, border: Border.all(color: Colors.blue)),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.white),
            // prefix: Icon(icon),
            border: InputBorder.none),
      ),
    );
  }

  CollectionReference ref = FirebaseFirestore.instance.collection('hotels');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
      ),

      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  dynamic doc = snapshot.data!.docs[index].data();

                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.white,
                      onPressed: () {
                        nameController.text = doc['name'];
                        desController.text = doc['Description'];
                        priceController.text = doc['Price'];
                        imageUrlController.text = doc['ImageUrl'];

                        showDialog(
                            context: context,
                            builder: (context) => Dialog(
                                  child: Container(
                                    color: primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ListView(
                                        shrinkWrap: true,
                                        children: <Widget>[
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              nameController, 'Name'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              desController, 'Description'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              priceController, 'Price'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          _buildTextField(
                                              imageUrlController, 'ImageUrl'),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  snapshot.data!.docs[index]
                                                      .reference
                                                      .update({
                                                    "name": nameController.text,
                                                    "Description":
                                                        desController.text,
                                                    "Price":
                                                        priceController.text,
                                                    "ImageUrl":
                                                        imageUrlController.text,
                                                  }).whenComplete(() =>
                                                          Navigator.pop(
                                                              context));
                                                },
                                                child: Text(
                                                  "Update Hotel",
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                snapshot
                                                    .data!.docs[index].reference
                                                    .delete()
                                                    .whenComplete(() =>
                                                        Navigator.pop(context));
                                              },
                                              child: Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.red),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ));
                      },
                    ),
                    title: Text(
                      doc['name'],
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Column(
                      children: <Widget>[
                        Text(
                          doc['Description'],
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          doc['Price'],
                          style: TextStyle(color: Colors.blue),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                    trailing: Image.network(doc['ImageUrl'],
                        height: 100, width: 100, fit: BoxFit.cover),
                  );
                });
          } else
            return Text('');
        },
      ),
    );
  }
}
