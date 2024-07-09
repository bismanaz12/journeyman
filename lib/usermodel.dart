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
  Usermodel(
      {required this.email,
      required this.techId,
      required this.id,
      required this.name,
      required this.pass,
      required this.address,
      required this.bio,
      required this.image,
      required this.persontype,
      required this.service});

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
      'techId': techId
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
        service: map['service'],
        persontype: map['persontype'],
        techId: map['techId']);
  }
}

// enum personType { customer, technician }
