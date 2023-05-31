import 'package:flutter/material.dart';
import 'package:trip_now/Admin/Manage_Hotel.dart';
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
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {},
                splashColor: Colors.cyan,
                child: Center(
                    child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.people,
                      size: 70.0,
                    ),
                    Text(
                      "Manage User",
                      style: new TextStyle(fontSize: 17.0),
                    )
                  ],
                )),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddHotelScreen()));
                },
                splashColor: Colors.cyan,
                child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.hotel,
                          size: 70.0,
                        ),
                        Text(
                          "Manage Hotel",
                          style: new TextStyle(fontSize: 17.0),
                        )
                      ],
                    )),
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
                },
                splashColor: Colors.cyan,
                child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.logout,
                          size: 70.0,
                        ),
                        Text(
                          "Logout",
                          style: new TextStyle(fontSize: 17.0),
                        )
                      ],
                    )),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
