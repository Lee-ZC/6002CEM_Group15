import 'package:flutter/material.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key? key}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person,size: 100,),
                          radius: 80,
                        ),
                        Positioned(
                          child: Container(child: Icon(Icons.edit,size: 70,)),
                          bottom: -8,
                          right: -7,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Name"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
