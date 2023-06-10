import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../api/notification_api.dart';

class DetailPage extends StatefulWidget {
  //const DetailPage({Key? key}) : super(key: key);

  final DocumentSnapshot post;

  DetailPage({required this.post});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final user = FirebaseAuth.instance.currentUser!;

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  //DatePickerDialog dateController = DatePickerDialog(initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2101));
  DateTimeRange dateRange =
      DateTimeRange(start: DateTime.now(), end: DateTime(2023, 12, 31));
  TextEditingController dateinput = TextEditingController();

  late Map<String, dynamic> hotelToBook;

  CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("Users");

  Color secondaryColor = Color(0xff232c51);

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
    final start = dateRange.start;
    final end = dateRange.end;

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
                            semanticLabel:
                                'Text to announce in accessibility modes',
                          ),
                          onPressed: () {},
                        ),
                        ElevatedButton(
                          child: Text("Book Now"),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListView(
                                            shrinkWrap: true,
                                            children: <Widget>[
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  nameController, 'Guest Name'),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              _buildTextField(
                                                  phoneController, 'Phone'),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              // Row(
                                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              //   children: [
                                              //     Expanded(child: ElevatedButton(
                                              //       child: Text("${start.year}/${start.month}/${end.day}"),
                                              //       onPressed:
                                              //         pickDateRange,
                                              //     )
                                              //     ),
                                              //     SizedBox(width: 12,),
                                              //     Expanded(child: ElevatedButton(
                                              //       child: Text("${end.year}/${end.month}/${end.day}"),
                                              //       onPressed:
                                              //         pickDateRange,
                                              //     )
                                              //     ),
                                              //   ],
                                              // ),
                                              TextField(
                                                controller: dateinput,
                                                decoration: InputDecoration(
                                                    icon: Icon(
                                                        Icons.calendar_today),
                                                    labelText:
                                                        "Select Booking Date"),
                                                readOnly: true,
                                                onTap: () async {
                                                  DateTime? pickedDate =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime(2000),
                                                          lastDate:
                                                              DateTime(2025));

                                                  // DateTimeRange? pickedDate =
                                                  //     await showDateRangePicker(
                                                  //         context: context,
                                                  //         firstDate:
                                                  //             DateTime(2023),
                                                  //         lastDate:
                                                  //             DateTime(2025));
                                                  if (pickedDate != null) {
                                                    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                    setState(() {dateinput.text = formattedDate; //set output date to TextField value.
                                                    });
                                                  }
                                                  else {
                                                    print("Date is not selected");
                                                  }
                                                },
                                              ),

                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      hotelToBook = {
                                                        "Guest name":
                                                            nameController.text,
                                                        "Phone number":
                                                            phoneController
                                                                .text,
                                                        "Date": dateinput.text,
                                                        "Hotel name": widget.post["name"],
                                                        "Hotel Image": widget.post["ImageUrl"]
                                                      };
                                                      collectionReference
                                                          .doc(user.uid)
                                                          .collection(
                                                              'Booking-Hotel-List')
                                                          .add(hotelToBook)
                                                          .whenComplete(() =>
                                                              Navigator.pop(
                                                                  context));

                                                      // NotificationApi.showNotification(
                                                      //     title: "Trip_now",
                                                      //     body: 'You have book ' + widget.post["name"],
                                                      //     payload: 'asda',);


                                                    },
                                                    child: Text(
                                                      "Book Now",
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  // Future pickDateRange() async {
  //   DateTimeRange? newDateRange = await showDateRangePicker(
  //       context: context,
  //       initialDateRange: dateRange,
  //       firstDate: DateTime(2000),
  //       lastDate: DateTime(2025)
  //   );
  //
  //   if (newDateRange == null) return ;
  //
  //   setState(() => dateRange = newDateRange);
  //
  // }
}
