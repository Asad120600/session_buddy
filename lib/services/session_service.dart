import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SessionService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> logSession({
    required String strainName,
    required int dosage,
    required String method,
    required DateTime timestamp,
    required int buzzScore,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('No user logged in');

    await _firestore.collection('sessions').add({
      'user_id': user.uid,
      'strain_name': strainName,
      'dosage': dosage,
      'consumption_method': method,
      'timestamp': timestamp,
      'buzz_score': buzzScore,
    });
  }

  Future<int?> fetchLatestBuzzScore() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final query = await _firestore
        .collection('sessions')
        .where('user_id', isEqualTo: user.uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (query.docs.isEmpty) return null;
    return query.docs.first.data()['buzz_score'] as int;
  }

  Future<Map<String, dynamic>?> fetchLatestSession() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return null;

  final query = await FirebaseFirestore.instance
      .collection('sessions')
      .where('user_id', isEqualTo: user.uid)
      .orderBy('timestamp', descending: true)
      .limit(1)
      .get();

  if (query.docs.isEmpty) return null;
  return query.docs.first.data();
}

}
