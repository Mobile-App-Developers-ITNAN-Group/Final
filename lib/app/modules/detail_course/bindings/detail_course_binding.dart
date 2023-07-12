import 'package:get/get.dart';

import '../controllers/detail_course_controller.dart';

class DetailCourseBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCourseController>(
      () => DetailCourseController(),
    );
  }
}
