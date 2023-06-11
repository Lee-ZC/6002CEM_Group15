import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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


                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                        onPressed: () {
                          // Code for editing the hotel details
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
                                              String newName = nameController.text.trim();
                                              String newDescription = desController.text.trim();
                                              String newPrice = priceController.text.trim();
                                              String newImageUrl = imageUrlController.text.trim();

                                              if (newName.isEmpty || newDescription.isEmpty || newPrice.isEmpty || newImageUrl.isEmpty) {
                                                Fluttertoast.showToast(
                                                  msg: 'Please fill in all fields',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.grey,
                                                  textColor: Colors.white,
                                                );
                                                return;
                                              }

                                              snapshot.data!.docs[index].reference.update({
                                                "name": newName,
                                                "Description": newDescription,
                                                "Price": newPrice,
                                                "ImageUrl": newImageUrl,
                                              }).then((_) {
                                                Fluttertoast.showToast(
                                                  msg: 'Hotel updated successfully!',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.green,
                                                  textColor: Colors.white,
                                                );
                                                Navigator.pop(context);
                                              }).catchError((error) {
                                                Fluttertoast.showToast(
                                                  msg: 'Failed to update hotel. Please try again.',
                                                  toastLength: Toast.LENGTH_SHORT,
                                                  gravity: ToastGravity.BOTTOM,
                                                  backgroundColor: Colors.red,
                                                  textColor: Colors.white,
                                                );
                                              });
                                            },
                                            child: Text("Update Hotel"),
                                          ),


                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  title: Text("Confirm Deletion"),
                                                  content: Text("Are you sure you want to delete this hotel?"),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        snapshot.data!.docs[index].reference.delete().then((_) {
                                                          Fluttertoast.showToast(
                                                            msg: 'Hotel deleted successfully!',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                            backgroundColor: Colors.green,
                                                            textColor: Colors.white,
                                                          );
                                                          Navigator.pop(context);
                                                        }).catchError((error) {
                                                          Fluttertoast.showToast(
                                                            msg: 'Failed to delete hotel. Please try again.',
                                                            toastLength: Toast.LENGTH_SHORT,
                                                            gravity: ToastGravity.BOTTOM,
                                                            backgroundColor: Colors.red,
                                                            textColor: Colors.white,
                                                          );
                                                        });
                                                      },
                                                      child: Text("Delete"),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(color: Colors.white),
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
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 8),
                          Text(
                            doc['Description'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            doc['Price'],
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      trailing: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          doc['ImageUrl'],
                          height: 120,
                          width: 120,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );



                });
          } else
            return Text('');
        },
      ),
    );
  }
}
