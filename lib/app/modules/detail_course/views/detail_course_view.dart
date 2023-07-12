import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../data/models/course_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_course_controller.dart';

class DetailCourseView extends GetView<DetailCourseController> {
  DetailCourseView({Key? key}) : super(key: key);

  final CourseModel course = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = course.code;
    nameC.text = course.name;
    qtyC.text = "${course.qty}";

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL COURSES'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImage(
                  data: course.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: "Course Code",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Course Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: qtyC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Attendance",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoadingUpdate.isFalse) {
                if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                  controller.isLoadingUpdate(true);
                  Map<String, dynamic> result= await controller.editCourse({
                    "id": course.courseId,
                    "name": nameC.text,
                    "qty": int.tryParse(qtyC.text) ?? 0,
                  });
                  controller.isLoadingUpdate(false);

                  Get.snackbar(
                    result["error"] == true ? "Error" : "Success",
                    result["message"],
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  Get.snackbar(
                    "Error",
                    "All data must be filled.",
                    duration: const Duration(seconds: 2),
                  );
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () => Text(controller.isLoadingUpdate.isFalse ? "UPDATE COURSE" : "LOADING..."),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.defaultDialog(
                title: "Delete Course",
                middleText: "Are you sure to delete this course ?",
                actions: [
                  OutlinedButton(
                    onPressed: () => Get.back(),
                    child: const Text("CANCEL"),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      controller.isLoadingDelete(true);
                      Map<String, dynamic> result= await controller.deleteCourse(course.courseId);
                      controller.isLoadingDelete(false);

                      Get.back(); // close dialog
                      Get.back(); // Balik ke page all products

                      Get.snackbar(
                        result["error"] == true ? "Error" : "Success",
                        result["message"],
                        duration: const Duration(seconds: 2),
                      );
                    },
                    child: Obx(
                      () => controller.isLoadingDelete.isFalse
                          ? const Text("DELETE")
                          : Container(
                              padding: const EdgeInsets.all(2),
                              height: 15,
                              width: 15,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 1,
                              ),
                            ),
                    ),
                  ),
                ],
              );
            },
            child: Text(
              "Delete course",
              style: TextStyle(
                color: Colors.red.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
