import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late int id;
  late String name;
  late String gender;
  late int age;
  User(
      {required this.age,
      required this.gender,
      required this.id,
      required this.name});
  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'gender': gender, 'age': age};
  }

  User.fromDocument(DocumentSnapshot doc)
      : id = doc['id'],
        name = doc['name'],
        gender = doc['gender'],
        age = doc['age'];
}
