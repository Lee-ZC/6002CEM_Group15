import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class DatabaseService {
  static Future<List<Map<String, dynamic>>> getUsers() async {
    try {
      CollectionReference _collectionRef =
          FirebaseFirestore.instance.collection('Users');

      QuerySnapshot querySnapshot = await _collectionRef.get();

      // Get data from docs and convert map to List
      List<Map<String, dynamic>> userList = querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();

      return userList;
    } catch (error) {
      throw error;
    }
  }

  static Future<void> createUser(
      String email, String password, String name) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid);

      await users.set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'name': name,
        'email': FirebaseAuth.instance.currentUser!.email,
      });
    } catch (error) {
      throw error;
    }
  }

  static Future<String?> getUserName(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        return userData['name'] as String?;
      }

      return null; // User document does not exist
    } catch (error) {
      throw error;
    }
  }

  static Future<String?> getEmail(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('Users')
          .doc(userId)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic> userData = snapshot.data()!;
        return userData['email'] as String?;
      }

      return null; // User document does not exist
    } catch (error) {
      throw error;
    }
  }

  static void update({
    required String name,
    required String email,
    required String userId,
    required String password,
    required BuildContext context,
  }) async {
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20),
                Text('Updating...'),
              ],
            ),
          ),
        ),
      );

      var collection = FirebaseFirestore.instance.collection('Users');
      collection
          .doc(FirebaseAuth.instance.currentUser?.uid.toString())
          .update({
        'name': name,
        'email': email,
      }) // <-- Updated data
          .then((_) => print('Success'))
          .catchError((error) => print(error));

      FirebaseAuth.instance.currentUser
          ?.updateEmail(email)
          .then((value) =>
          FirebaseAuth.instance.currentUser?.updatePassword(password))
          .then((value) => FirebaseAuth.instance.signOut());

      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } catch (error) {
      Navigator.of(context).pop(); // Dismiss the progress dialog
      print('Error updating database: $error');
      // Handle the error
    }
  }
}
