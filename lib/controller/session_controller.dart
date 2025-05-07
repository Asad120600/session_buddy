import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:session_buddy/model/session_model.dart';
import 'package:session_buddy/view/result/buzz_score_result_screen.dart';

class SessionController extends GetxController {
  // Observable variables
  var strainName = ''.obs;
  var dosage = 0.0.obs;
  var consumptionMethod = ''.obs;
  var buzzScore = 0.obs;
  var buzzDescription = ''.obs;
  var selectedDateTime = DateTime.now().obs;
  var isLoading = false.obs;

  // Firebase Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Clear all fields
  void clearFields() {
    strainName.value = '';
    dosage.value = 0.0;
    consumptionMethod.value = '';
    buzzScore.value = 0;
    buzzDescription.value = '';
    selectedDateTime.value = DateTime.now();
  }

  // Calculate buzz score
  int calculateBuzzScore(double dosage, String method) {
    int baseScore = (dosage * (method.toLowerCase() == 'edible' ? 2 : 1)).toInt();
    return baseScore.clamp(1, 10);
  }

  // Get buzz description
  String getBuzzDescription(int score) {
    if (score <= 3) {
      return "Light buzz, feeling relaxed.";
    } else if (score <= 6) {
      return "Nice buzz, feeling good.";
    } else {
      return "Heavy buzz, time to chill.";
    }
  }

  // Store session in Firebase
  Future<void> saveSession(String userId) async {
    try {
      isLoading.value = true;

      // Calculate buzz score and description
      buzzScore.value = calculateBuzzScore(dosage.value, consumptionMethod.value);
      buzzDescription.value = getBuzzDescription(buzzScore.value);

      // Create session model
      SessionModel session = SessionModel(
        userId: userId, // You might want to get this from your auth system
        strainName: strainName.value,
        dosage: dosage.value,
        consumptionMethod: consumptionMethod.value,
        timestamp: selectedDateTime.value,
        buzzScore: buzzScore.value,
        buzzDescription: buzzDescription.value,
      );

      // Save to Firebase
      await _firestore.collection('sessions').add(session.toFirestore());

      // Navigate to result screen
      Get.to(() => BuzzScoreResultScreen(
            buzzScore: buzzScore.value,
            buzzDescription: buzzDescription.value,
          ));

      // Clear fields after successful save
      clearFields();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to save session: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Validate inputs
  bool validateInputs() {
    if (strainName.value.isEmpty) {
      Get.snackbar('Error', 'Please enter strain name');
      return false;
    }
    if (dosage.value <= 0) {
      Get.snackbar('Error', 'Please enter a valid dosage');
      return false;
    }
    if (consumptionMethod.value.isEmpty) {
      Get.snackbar('Error', 'Please select consumption method');
      return false;
    }
    return true;
  }
}