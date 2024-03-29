import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService({required this.uid});

  Future<void> addData(userData) async {
    FirebaseFirestore.instance.collection("users").add(userData).catchError((e) {
      // print(e);
    });
  }

  getData() async {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  Future<void> addQuizData(quizData, String quizId) async {
    await FirebaseFirestore.instance.collection("QuizList").doc(quizId).set(quizData).catchError((e) {
      // print(e);
    });
  }

  Future<void> addQuestionData(quizData, String quizId) async {
    await FirebaseFirestore.instance.collection("QuizList").doc(quizId).collection("Questions").add(quizData).catchError((e) {
      // print(e);
    });
  }

  getQuizData() async {
    return FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  getQuestionData(String quizId) async {
    return await FirebaseFirestore.instance.collection("QuizList").doc(quizId).collection("Questions").get();
  }
}
