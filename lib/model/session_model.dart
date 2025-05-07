import 'package:cloud_firestore/cloud_firestore.dart';

class SessionModel {
  final String userId;
  final String strainName;
  final double dosage;
  final String consumptionMethod;
  final DateTime timestamp;
  final int buzzScore;
  final String buzzDescription;

  SessionModel({
    required this.userId,
    required this.strainName,
    required this.dosage,
    required this.consumptionMethod,
    required this.timestamp,
    required this.buzzScore,
    required this.buzzDescription,
  });

  // Convert Firestore document to SessionModel object
  factory SessionModel.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return SessionModel(
      userId: firestoreDoc['userId'] ?? '',
      strainName: firestoreDoc['strainName'] ?? '',
      dosage: firestoreDoc['dosage'] ?? 0.0,
      consumptionMethod: firestoreDoc['consumptionMethod'] ?? '',
      timestamp: (firestoreDoc['timestamp'] as Timestamp).toDate(),
      buzzScore: firestoreDoc['buzzScore'] ?? 0,
      buzzDescription: firestoreDoc['buzzDescription'] ?? '',
    );
  }

  // Convert SessionModel object to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'strainName': strainName,
      'dosage': dosage,
      'consumptionMethod': consumptionMethod,
      'timestamp': Timestamp.fromDate(timestamp),
      'buzzScore': buzzScore,
      'buzzDescription': buzzDescription,
    };
  }
}
