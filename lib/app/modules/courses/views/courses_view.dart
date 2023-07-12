import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../data/models/course_model.dart';
import '../../../routes/app_pages.dart';
import '../controllers/courses_controller.dart';

class CoursesView extends GetView<CoursesController> {
  const CoursesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('COURSES'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.streamCourses(),
        builder: (context, snapCourses) {
          if (snapCourses.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapCourses.data!.docs.isEmpty) {
            return const Center(
              child: Text("No Courses"),
            );
          }

          List<CourseModel> allCourses = [];

          for (var element in snapCourses.data!.docs) {
            allCourses.add(CourseModel.fromJson(element.data()));
          }

          return ListView.builder(
            itemCount: allCourses.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              CourseModel course = allCourses[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.only(bottom: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: InkWell(
                  onTap: () {
                    Get.toNamed(Routes.detailCourse, arguments: course);
                  },
                  borderRadius: BorderRadius.circular(9),
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                course.code,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(course.name),
                              Text("Attendance : ${course.qty}"),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: QrImage(
                            data: course.code,
                            size: 200.0,
                            version: QrVersions.auto,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
