import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailCourseController extends GetxController {
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> editCourse(Map<String, dynamic> data) async {
    try {
      await firestore.collection("courses").doc(data["id"]).update({
        "name": data["name"],
        "att": data["att"],
      });

      return {
        "error": false,
        "message": "Course updated.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Unable to update the course.",
      };
    }
  }

  Future<Map<String, dynamic>> deleteCourse(String id) async {
    try {
      await firestore.collection("courses").doc(id).delete();
      return {
        "error": false,
        "message": "Course Deleted.",
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Unable to delete the course.",
      };
    }
  }
}
