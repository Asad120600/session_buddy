import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore for Timestamp

class SubscriptionModel {
  final String userId;
  final String planType;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;

  SubscriptionModel({
    required this.userId,
    required this.planType,
    required this.startDate,
    required this.endDate,
    required this.isActive,
  });

  // Convert Firestore document to SubscriptionModel object
  factory SubscriptionModel.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return SubscriptionModel(
      userId: firestoreDoc['userId'] ?? '',
      planType: firestoreDoc['planType'] ?? 'free',
      startDate: (firestoreDoc['startDate'] as Timestamp).toDate(),
      endDate: (firestoreDoc['endDate'] as Timestamp).toDate(),
      isActive: firestoreDoc['isActive'] ?? false,
    );
  }

  // Convert SubscriptionModel object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'planType': planType,
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'isActive': isActive,
    };
  }
}
