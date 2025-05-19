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

  // Firestore instance
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Constants
  static const int maxDosage = 50;

  // Clear fields
  void clearFields() {
    strainName.value = '';
    dosage.value = 0.0;
    consumptionMethod.value = '';
    buzzScore.value = 0;
    buzzDescription.value = '';
    selectedDateTime.value = DateTime.now();
  }

  // Calculate buzz score (1–10)
  int calculateBuzzScore(double dosage, String method) {
    int baseScore = (dosage * (method.toLowerCase() == 'edible' ? 2 : 1)).toInt();
    return baseScore.clamp(1, 10);
  }

  // Calculate buzz percentage (for CircularProgress)
  double calculateBuzzPercentage(double dosage, String method) {
    double weighted = dosage * (method.toLowerCase() == 'edible' ? 2 : 1);
    return (weighted / maxDosage).clamp(0.0, 1.0) * 100;
  }

  // Buzz description
  String getBuzzDescription(int score) {
    if (score <= 3) return "Light buzz, feeling relaxed.";
    if (score <= 6) return "Nice buzz, feeling good.";
    return "Heavy buzz, time to chill.";
  }

  // Validate form inputs
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

  // Save session and navigate to result
  Future<void> saveSession(String userId) async {
    if (!validateInputs()) return;

    try {
      isLoading.value = true;

      buzzScore.value = calculateBuzzScore(dosage.value, consumptionMethod.value);
      buzzDescription.value = getBuzzDescription(buzzScore.value);
      double progress = calculateBuzzPercentage(dosage.value, consumptionMethod.value);

      // Create model
      SessionModel session = SessionModel(
        userId: userId,
        strainName: strainName.value,
        dosage: dosage.value,
        consumptionMethod: consumptionMethod.value,
        timestamp: selectedDateTime.value,
        buzzScore: buzzScore.value,
        buzzDescription: buzzDescription.value,
      );

      await _firestore.collection('sessions').add(session.toFirestore());

      // Navigate with actual progress value
      Get.to(() => BuzzScoreResultScreen(
            buzzScore: buzzScore.value,
            buzzDescription: buzzDescription.value,
            progressPercentage: progress,
          ));

      clearFields();
    } catch (e) {
      Get.snackbar('Error', 'Failed to save session: $e',
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
