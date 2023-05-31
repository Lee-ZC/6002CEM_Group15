import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trip_now/Admin/HotelList.dart';

class AddHotelScreen extends StatefulWidget {
  const AddHotelScreen({Key? key}) : super(key: key);

  @override
  State<AddHotelScreen> createState() => _AddHotelScreenState();
}

class _AddHotelScreenState extends State<AddHotelScreen> {
  Color primaryColor = Color(0xff18203d);
  Color secondaryColor = Color(0xff232c51);
  Color logoGreen = Color(0xff25bcbb);

  TextEditingController nameController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();

  late Map<String, dynamic> hotelToAdd;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("hotels");

  addHotel() {
    hotelToAdd = {
      "name": nameController.text,
      "Description": desController.text,
      "Price": priceController.text,
      "ImageUrl": imageUrlController.text,
    };

    collectionReference
        .add(hotelToAdd)
        .whenComplete(() => print("Add to database"));
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_)=>hotelList()));
            },
            icon: Icon(
              Icons.folder_open,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: Colors.purple[100],
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Manage Hotel',
              style: TextStyle(
                  color: Colors.blueAccent,
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            _buildTextField(nameController, 'Name'),
            SizedBox(
              height: 20,
            ),
            _buildTextField(desController, 'Description'),
            SizedBox(
              height: 20,
            ),
            _buildTextField(priceController, 'Price'),
            SizedBox(
              height: 20,
            ),
            _buildTextField(imageUrlController, 'ImageUrl'),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                  onPressed: () {
                    addHotel();
                  },
                  child: Text(
                    "Add Hotel",
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
