import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String id;
  final String name;
  final String email;
  final String bio;
  final String photoUrl;
  final String instagramName;
  final String tiktokName;

  User(
      {this.id,
      this.username,
      this.name,
      this.instagramName,
      this.tiktokName,
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
        name: doc['displayName'],
        instagramName: doc['instagramName'],
        tiktokName: doc['tiktokName']);
  }
}
