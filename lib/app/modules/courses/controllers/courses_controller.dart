import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CoursesController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> streamCourses() async* {
    yield* firestore.collection("courses").snapshots();
  }
}
