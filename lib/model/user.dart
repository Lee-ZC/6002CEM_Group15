import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser {
  final String id;
  final String name;
  final String email;

  CurrentUser({required this.id, required this.name, required this.email });



}
