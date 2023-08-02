import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late int id;
  late String name;
  late String gender;
  late int age;
  late String profile;
  late List<dynamic> profileCover;
  User(
      {required this.age,
      required this.gender,
      required this.id,
      required this.name,
      required this.profile,
      required this.profileCover});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'age': age,
      'profile_image': profile,
      'profile_cover': profileCover
    };
  }

  User.fromDocument(DocumentSnapshot doc)
      : id = doc['id'],
        name = doc['name'],
        gender = doc['gender'],
        age = doc['age'],
        profile = doc['profile_image'],
        profileCover = doc['profile_cover'];
}
