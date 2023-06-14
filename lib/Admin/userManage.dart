import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_now/database.dart';


class UserManage extends StatefulWidget{

  const UserManage({Key? key}) : super(key: key);

  @override
  State<UserManage> createState() => _UserManageState();

}
List allData=[];
class _UserManageState extends State<UserManage>  {

// Step 2
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }
// Step 3
  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Users');

  @override
  Widget build(BuildContext context) {
    Future <dynamic> getUsers() async{
      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
       allData = querySnapshot.docs.map((doc) => doc.data()).toList();
      setState(() {

      });
    }
    getUsers();


    return Scaffold(
          appBar: AppBar(title: Text('Trip Now: Admin'),),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          showCheckboxColumn: false,
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Text(
                  'Uid',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Name',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  'Email',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],

           rows:
           allData!.map((e) =>
    DataRow(
          cells: <DataCell>[
            DataCell(Text(e['uid'])),
            DataCell(Text(e['name'])),
            DataCell(Text(e['email'])),
          ],
      onSelectChanged: (value)=> showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure want to delete this user.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
        ),).toList(),
            //[
          //   DataRow(
          //     cells: <DataCell>[
          //       DataCell(Text('uid')),
          //       DataCell(Text('name')),
          //       DataCell(Text('email')),
          //     ],
          //   ),
          // ],


        ),
      )
        );

  }



}
