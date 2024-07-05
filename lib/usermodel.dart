class Usermodel {
  String name;
  String id;
  String pass;
  String email;

  Usermodel(
      {required this.email,
      required this.id,
      required this.name,
      required this.pass});

  Map<String, dynamic> toMap() {
    return {'email': email, 'password': pass, 'name': name, 'id': id};
  }

  factory Usermodel.fromMap(Map<String, dynamic> map) {
    return Usermodel(
        email: map['email'],
        id: map['id'],
        name: map['name'],
        pass: map['password']);
  }
}
