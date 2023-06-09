import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_now/main.dart';
import 'package:trip_now/model/user.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Trip Now'),
    //     ),
    //     body: SingleChildScrollView(
    //       child: Form(
    //         key: _formKey,
    //         child: Column(
    //           children: [
    //             Padding(
    //               padding: const EdgeInsets.all(15),
    //               child: TextFormField(
    //                 validator: (value){
    //                   if (value == null || value.isEmpty) {
    //                     return 'Please enter some text';
    //                   }
    //                   return null;
    //                 },
    //                 controller: nameController,
    //                 decoration: const InputDecoration(
    //                     border: OutlineInputBorder(),
    //                     labelText: 'Name',
    //                     hintText: 'Enter your name.'),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(15),
    //               child: TextFormField(
    //                 validator: (value){
    //                   final bool emailValid =
    //                   RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //                       .hasMatch(value!);
    //                   if (value == null || value.isEmpty) {
    //                     return 'Please enter some text';
    //                   }else if(!emailValid){
    //                     return 'Please enter a valid email';
    //                   }
    //                   return null;
    //                 },
    //                 controller: emailController,
    //                 decoration: const InputDecoration(
    //                     border: OutlineInputBorder(),
    //                     labelText: 'Email',
    //                     hintText: 'Enter valid email.'),
    //               ),
    //             ),
    //             Padding(
    //               padding: const EdgeInsets.all(15),
    //               child: TextFormField(
    //                 validator: (value){
    //                   if (value == null || value.isEmpty) {
    //                     return 'Please enter some text';
    //                   }
    //                   return null;
    //                 },
    //                 controller: passwordController,
    //                 obscureText: true,
    //                 decoration: const InputDecoration(
    //                     border: OutlineInputBorder(),
    //                     labelText: 'Password',
    //                     hintText: 'Enter the password.'),
    //               ),
    //             ),
    //             const SizedBox(
    //               height: 20,
    //             ),
    //             SizedBox(
    //               width: 100,
    //               height: 50,
    //               child: ElevatedButton(
    //                 child: const Text(
    //                   "Sign up",
    //                   style: TextStyle(
    //                     fontSize: 20,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 onPressed: () {
    //                   if(_formKey.currentState!.validate()){
    //                     signUp();
    //                   }
    //
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ));
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: CircleAvatar(backgroundImage: AssetImage('assets/images/logo.png',),radius: 80.0,),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  validator: (value) {
                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Name',
                      hintText: 'Enter Name.'),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  validator: (value) {
                    final bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (!emailValid) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(90.0),
                      ),
                      labelText: 'Email',
                      hintText: 'Enter valid email.'),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (value.length < 6) {
                      return 'Password must be more than 6 digits.';
                    }
                    return null;
                  },
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90.0),
                    ),
                    labelText: 'Password',
                  ),
                ),
              ),
              Container(
                  height: 90,
                  width: 180,
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                    ),
                    child: const Text('Login'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        signUp();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      DocumentReference<Map<String, dynamic>> users = FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      users.set({
        'uid': FirebaseAuth.instance.currentUser!.uid,
        'name': nameController.text.toString(),
        'email': FirebaseAuth.instance.currentUser!.email,
      }).catchError((error) => print("Failed to add user: $error"));
    } on FirebaseAuthException catch (e) {
      final snackBar = SnackBar(
        content: const Text('Some errors occured, try it later.'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
