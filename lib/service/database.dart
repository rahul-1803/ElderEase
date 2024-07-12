import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addQuizCategory(
      Map<String, dynamic> userQuizCategory, String category) async {
    return await FirebaseFirestore.instance
        .collection(category)
        .add(userQuizCategory);
  }

  Future<Stream<QuerySnapshot>> getCategoryQuiz(String category) async {
    return FirebaseFirestore.instance.collection(category).snapshots();
  }
}

class DataBaseMethods_reward {
  Future addOrUpdateEmployeeDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    CollectionReference leaderboard =
        FirebaseFirestore.instance.collection('leaderboard');
    QuerySnapshot querySnapshot = await leaderboard
        .where('Name', isEqualTo: employeeInfoMap['Name'])
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot existingDoc = querySnapshot.docs.first;
      int existingCorrectAnswers = existingDoc['correct answer'];
      int existingWrongAnswers = existingDoc['wrong answer'];

      await leaderboard.doc(existingDoc.id).update({
        'correct answer':
            existingCorrectAnswers + employeeInfoMap['correct answer'],
        'wrong answer': existingWrongAnswers + employeeInfoMap['wrong answer'],
      });
    } else {
      await leaderboard.doc(id).set(employeeInfoMap);
    }
  }

  Stream<QuerySnapshot> getEmployeeDetails() {
    return FirebaseFirestore.instance.collection('leaderboard').snapshots();
  }
}
