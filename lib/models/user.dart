import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String id;
  final String displayName;
  final String email;
  final String bio;
  final String photoUrl;

  User(
      {this.id,
      this.username,
      this.displayName,
      this.email,
      this.bio,
      this.photoUrl});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        id: doc['id'],
        email: doc['email'],
        username: doc['username'],
        photoUrl: doc['photoUrl'],
        bio: doc['bio'],
        displayName: doc['displayName']);
  }
}
