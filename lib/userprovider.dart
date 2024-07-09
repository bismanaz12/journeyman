import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mechanic_app/usermodel.dart';

class UserProvider with ChangeNotifier {
  Usermodel? user;
  getuser() async {
    user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) => Usermodel.fromMap(value.data()!));
    notifyListeners();
  }

  // changepass(String pass, String pass2) async {
  //   log('user is:$user ');
  //   if (pass == user!.pass) {
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(FirebaseAuth.instance.currentUser!.uid)
  //         .update({'password': pass2});
  //   }
  //   notifyListeners();
  // }
}
