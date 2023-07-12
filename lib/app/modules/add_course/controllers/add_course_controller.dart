import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddCourseController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addCourse(Map<String, dynamic> data) async {
    try {
      var result = await firestore.collection("courses").add(data);
      await firestore.collection("courses").doc(result.id).update({
        "courseId": result.id,
      });

      return {
        "error": false,
        "message": "Class created successfully.",
      };
    } catch (e) {
      // Error general
      print(e);
      return {
        "error": true,
        "message": "Unable to create the Class.",
      };
    }
  }
}
