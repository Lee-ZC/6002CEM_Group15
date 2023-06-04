import 'package:firebase_auth/firebase_auth.dart';

class User {
  final String id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  final user = FirebaseAuth.instance.currentUser!;

  String? getUID() {
    final String? uid = user?.uid.toString();

    return uid;
  }

  String? getUName() {
    final String? uname = user?.displayName.toString();

    return uname;
  }

  String? getUEmail() {
    final String? uemail = user?.email.toString();

    return uemail;
  }



}
