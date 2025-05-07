import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String email;
  final String subscriptionStatus;
  final DateTime createdAt;
  final DateTime lastLogin;

  UserModel({
    required this.uid,
    required this.email,
    required this.subscriptionStatus,
    required this.createdAt,
    required this.lastLogin,
  });

  // Convert Firestore document to UserModel object
  factory UserModel.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return UserModel(
      uid: firestoreDoc['uid'] ?? '',
      email: firestoreDoc['email'] ?? '',
      subscriptionStatus: firestoreDoc['subscriptionStatus'] ?? 'free',
      createdAt: (firestoreDoc['createdAt'] as Timestamp).toDate(),
      lastLogin: (firestoreDoc['lastLogin'] as Timestamp).toDate(),
    );
  }

  // Convert UserModel object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'subscriptionStatus': subscriptionStatus,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': Timestamp.fromDate(lastLogin),
    };
  }
}
