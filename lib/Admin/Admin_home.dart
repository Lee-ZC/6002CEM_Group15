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
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Admin Dashboard"),
        backgroundColor: Colors.purple[400],
      ),
      body: Container(
        child: Column(
          children: [
            InkWell(
              onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserManage()));},
              child: Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.white24))),
                        child: Icon(Icons.people, color: Colors.white),
                      ),
                      title: Text(
                        "User management",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0)),
                ),
              ),
            ),
            InkWell(
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddHotelScreen()));},
              child: Card(
                elevation: 8.0,
                margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration:
                  BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12.0),
                        decoration: new BoxDecoration(
                            border: new Border(
                                right: new BorderSide(
                                    width: 1.0, color: Colors.white24))),
                        child: Icon(Icons.hotel, color: Colors.white),
                      ),
                      title: Text(
                        "Hotel management",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                      trailing: Icon(Icons.keyboard_arrow_right,
                          color: Colors.white, size: 30.0)),
                ),
              ),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Log out')),
                    ))),
          ],
        ),
      ),
      // Container(
      //   padding: EdgeInsets.all(30.0),
      //   child: GridView.count(
      //     crossAxisCount: 2,
      //     children: <Widget>[
      //       Card(
      //         shape: RoundedRectangleBorder(
      //           side: const BorderSide(
      //             color: Colors.white,
      //           ),
      //           borderRadius: BorderRadius.circular(20.0),
      //         ),
      //         margin: EdgeInsets.all(8.0),
      //         child: InkWell(
      //           onTap: () {
      //             Navigator.of(context).push(MaterialPageRoute(builder: (context) => UserManage()));
      //           },
      //           splashColor: Colors.cyan,
      //           child: Center(
      //               child: Column(
      //             mainAxisSize: MainAxisSize.min,
      //             children: <Widget>[
      //               Icon(
      //                 Icons.people,
      //                 size: 70.0,
      //               ),
      //               Text(
      //                 "Manage User",
      //                 style: new TextStyle(fontSize: 17.0),
      //               )
      //             ],
      //           )),
      //         ),
      //       ),
      //       Card(
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide(
      //             color: Colors.white,
      //           ),
      //           borderRadius: BorderRadius.circular(20.0),
      //         ),
      //         margin: EdgeInsets.all(8.0),
      //         child: InkWell(
      //           onTap: () {
      //             Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddHotelScreen()));
      //           },
      //           splashColor: Colors.cyan,
      //           child: Center(
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: <Widget>[
      //                   Icon(
      //                     Icons.hotel,
      //                     size: 70.0,
      //                   ),
      //                   Text(
      //                     "Manage Hotel",
      //                     style: new TextStyle(fontSize: 17.0),
      //                   )
      //                 ],
      //               )),
      //         ),
      //       ),
      //       Card(
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide(
      //             color: Colors.white,
      //           ),
      //           borderRadius: BorderRadius.circular(20.0),
      //         ),
      //         margin: EdgeInsets.all(8.0),
      //         child: InkWell(
      //           onTap: () {
      //             Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
      //           },
      //           splashColor: Colors.cyan,
      //           child: Center(
      //               child: Column(
      //                 mainAxisSize: MainAxisSize.min,
      //                 children: <Widget>[
      //                   Icon(
      //                     Icons.logout,
      //                     size: 70.0,
      //                   ),
      //                   Text(
      //                     "Logout",
      //                     style: new TextStyle(fontSize: 17.0),
      //                   )
      //                 ],
      //               )),
      //         ),
      //       ),
      //
      //     ],
      //   ),
      // ),
    );
  }
}
