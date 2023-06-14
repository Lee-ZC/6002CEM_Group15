import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  TextEditingController dateinput = TextEditingController();
  TextEditingController priceController  = TextEditingController();

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


  Future<void> addToFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("user-favourite-hotels");

    return _collectionRef
        .doc(currentUser!.uid)
        .collection("hotels")
        .doc()
        .set({
      "Hotel name": widget.post["name"],
      "Price": widget.post["Price"],
      "ImageUrl": widget.post["ImageUrl"],
    }).then((value) => print("Added To favourite"));
  }

  Future<void> removeFromFavourite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;

    CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection("user-favourite-hotels");

    QuerySnapshot snapshot = await _collectionRef
        .doc(currentUser!.uid)
        .collection("hotels")
        .where("Hotel name", isEqualTo: widget.post["name"])
        .get();

    if (snapshot.docs.isNotEmpty) {
      String docId = snapshot.docs.first.id;
      await _collectionRef
          .doc(currentUser.uid)
          .collection("hotels")
          .doc(docId)
          .delete()
          .then((value) => print("Removed from favourites"));
    }
  }

  // Function to show a toast message
  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[900],
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }


  // FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  //
  // void initializeNotifications() async {
  //   const AndroidInitializationSettings initializationSettingsAndroid =
  //   AndroidInitializationSettings('app_icon');
  //   final InitializationSettings initializationSettings =
  //   InitializationSettings(android: initializationSettingsAndroid);
  //
  //   await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // }
  //
  //
  // Future<void> scheduleLocalNotification() async {
  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  //   AndroidNotificationDetails(
  //     'channel_id',
  //     'channel_name',
  //     'channel_description',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );
  //   const NotificationDetails platformChannelSpecifics =
  //   NotificationDetails(android: androidPlatformChannelSpecifics);
  //
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Hotel Booked',
  //     'Hotel booked successfully!',
  //     platformChannelSpecifics,
  //     payload: 'notification_payload',
  //   );
  // }


  Map<String, dynamic> weatherData = {};

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    final apiKey = '734454ae3dee8cbb3aade569fa83da3b'; // Replace with your OpenWeatherMap API key
    final cityName = widget.post["Location"]; // Replace with the location from your post

    final url = Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        weatherData = data;
      });
    } else {
      print('Failed to fetch weather data: ${response.statusCode}');
    }
  }

  String getFormattedTemperature() {
    if (weatherData.isNotEmpty) {
      final double temperature = weatherData['main']['temp'];
      final int celsiusTemperature = (temperature - 273.15).round();

      return '$celsiusTemperature°C'; // Display temperature in Celsius
    } else {
      return '';
    }
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Trip Now'),
      ),



      body: SingleChildScrollView(

        child: Container(
          color: Colors.lightBlue[50],

          padding: EdgeInsets.all(16.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post["name"],
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.0),
              Image.network(
                widget.post['ImageUrl'],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 25.0),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.post["Description"],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Location",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.post["Location"],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "Price",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.post["Price"],
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 30.0),
              // Text(
              //   "Weather",
              //   style: TextStyle(
              //     fontSize: 18.0,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              // if (weatherData.isNotEmpty)
              //   Column(
              //     children: [
              //       Text(
              //         'Temperature: ${weatherData['main']['temp']}',
              //         style: TextStyle(
              //           fontSize: 16.0,
              //           color: Colors.grey[600],
              //         ),
              //       ),
              //       Text(
              //         'Description: ${weatherData['weather'][0]['description']}',
              //         style: TextStyle(
              //           fontSize: 16.0,
              //           color: Colors.grey[600],
              //         ),
              //       ),
              //     ],
              //   ),
              Text(
                "Weather",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (weatherData.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Temperature : ${getFormattedTemperature()}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.left, // Align text to the left
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Description   : ''${weatherData['weather'][0]['description']}',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.left, // Align text to the left
                    ),
                    SizedBox(height: 5.0),
                  ],
                ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("user-favourite-hotels")
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection("hotels")
                        .where("Hotel name", isEqualTo: widget.post["name"])
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return Text("");
                      }

                      return IconButton(
                        onPressed: () {
                          if (snapshot.data.docs.length == 0) {
                            addToFavourite();
                            showToast("Added to favorites");
                          } else {
                            removeFromFavourite();
                            showToast("Removed from favorites");
                          }
                        },
                        icon: Icon(
                          snapshot.data.docs.length == 0
                              ? Icons.favorite_outline
                              : Icons.favorite,
                          color: Colors.red,
                          size: 24.0,
                        ),
                      );
                    },
                  ),


                  ElevatedButton(
                    child: Text("Book Now"),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => Dialog(
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Book Hotel",
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                _buildTextField(nameController, 'Guest Name'),
                                SizedBox(height: 8.0),
                                _buildTextField(phoneController, 'Phone'),
                                SizedBox(height: 8.0),
                                TextField(
                                  controller: dateinput,
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today),
                                    labelText: "Select Booking Date",
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTimeRange? pickedDateRange =
                                    await showDateRangePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2025),
                                    );

                                    if (pickedDateRange != null) {
                                      String formattedStartDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDateRange.start);
                                      String formattedEndDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDateRange.end);
                                      String formattedDateRange =
                                          "$formattedStartDate to $formattedEndDate";

                                      setState(() {
                                        dateinput.text = formattedDateRange;
                                      });
                                    } else {
                                      print("Date range is not selected");
                                    }
                                  },
                                ),

                                SizedBox(height: 16.0),
                                Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (nameController.text.isEmpty ||
                                          phoneController.text.isEmpty ||
                                          dateinput.text.isEmpty) {
                                        showToast(
                                            "Please fill in all the required fields.");
                                      } else {
                                        hotelToBook = {
                                          "Guest name": nameController.text,
                                          "Phone number": phoneController.text,
                                          "Date": dateinput.text,
                                          "Hotel name": widget.post["name"],
                                          "Hotel Image": widget.post["ImageUrl"]
                                        };
                                        collectionReference
                                            .doc(user.uid)
                                            .collection('Booking-Hotel-List')
                                            .add(hotelToBook)
                                            .then((value) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Success"),
                                              content: Text("Hotel booked successfully!"),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            ),
                                          );

                                          // Schedule local notification
                                          //scheduleLocalNotification();

                                          // Clear text fields
                                          nameController.clear();
                                          phoneController.clear();
                                          dateinput.clear();

                                        }).catchError((error) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text("Error"),
                                              content: Text("Failed to book the hotel. Please try again."),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: Text("OK"),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                      }
                                    },
                                    child: Text("Book Now"),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

}
