import 'package:flutter/material.dart';
import 'package:trip_now/Admin/Manage_Hotel.dart';
import 'package:trip_now/Admin/userManage.dart';
import 'package:trip_now/main.dart';
import 'package:trip_now/login.dart';



// void main(List<String> args) {
//   runApp(new MaterialApp(
//     home: MyAdminApp(),
//   ));
// }


class MyAdminApp extends StatefulWidget {
  const MyAdminApp({Key? key}) : super(key: key);

  @override
  State<MyAdminApp> createState() => _MyAdminAppState();
}




class _MyAdminAppState extends State<MyAdminApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.purple[400],
      ),
      backgroundColor: Colors.purple[100],


      body: Container(
        padding: EdgeInsets.all(30.0),
        child: GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Handle onTap for Manage User
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserManage()));

              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.all(8.0),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      size: 70.0,
                      color: Colors.blueAccent,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Manage User",
                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddHotelScreen()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.all(8.0),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.hotel,
                      size: 70.0,
                      color: Colors.green,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Manage Hotel",
                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: EdgeInsets.all(8.0),
                elevation: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.logout,
                      size: 70.0,
                      color: Colors.red,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Logout",
                      style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),



    );
  }
}
