import 'dart:io';

class Usermodel {
  String name;
  String id;
  String pass;
  String email;
  String image;
  String persontype;
  String service;
  String bio;
  String address;
  String techId;
  List<String> process;
  List<String> completion;
  List<String> cancel;
  List<String> ontrip;
  List<String> pending;
  int status;

  Usermodel(
      {required this.email,
      required this.status,
      required this.techId,
      required this.id,
      required this.name,
      required this.pass,
      required this.address,
      required this.bio,
      required this.image,
      required this.persontype,
      required this.process,
      required this.completion,
      required this.cancel,
      required this.service,
      required this.ontrip,
      required this.pending});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': pass,
      'name': name,
      'id': id,
      'bio': bio,
      'address': address,
      'image': image,
      'service': service,
      'persontype': persontype,
      'techId': techId,
      'completion': completion,
      'cancel': cancel,
      'process': process,
      'ontrip': ontrip,
      'pending': pending,
      'status':status
    };
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
        email: map['email'],
        id: map['id'],
        name: map['name'],
        pass: map['password'],
        address: map['address'],
        bio: map['bio'],
        image: map['image'],
        status:map['status'],
        service: map['service'],
        persontype: map['persontype'],
        techId: map['techId'],
        completion: List<String>.from(map['completion'] ?? []),
        cancel: List<String>.from(map['cancel'] ?? []),
        process: List<String>.from(
          map['process'] ?? [],
        ),
        ontrip: List<String>.from(map['ontrip'] ?? []),
        pending: List<String>.from(map['pending'] ?? []));
  }
}
