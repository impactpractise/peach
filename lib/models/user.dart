import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String id;
  final String name;
  final String email;
  final String bio;
  final String photoUrl;
  final String instagram;
  final String tiktok;
  final String youtube;

  User(
      {this.id,
      this.username,
      this.name,
      this.instagram,
      this.tiktok,
      this.email,
      this.bio,
      this.photoUrl,
      this.youtube});

  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
        id: doc['id'],
        email: doc['email'],
        username: doc['username'],
        photoUrl: doc['photoUrl'],
        bio: doc['bio'],
        name: doc['displayName'],
        instagram: doc['instagram'],
        tiktok: doc['tiktok'],
        youtube: doc['youtube']);
  }
}
