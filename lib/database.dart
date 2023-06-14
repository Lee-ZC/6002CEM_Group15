import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {

  static Future <List> getUsers() async{
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Users');

    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    return querySnapshot.docs.map((doc) => doc.data()).toList();


    }

}