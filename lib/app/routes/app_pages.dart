import 'package:get/get.dart';

import '../modules/add_course/bindings/add_course_binding.dart';
import '../modules/add_course/views/add_course_view.dart';
import '../modules/detail_course/bindings/detail_course_binding.dart';
import '../modules/detail_course/views/detail_course_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/signup/view/signup_view.dart';
import '../modules/signup/bindings/singnup_bindings.dart';
import '../modules/courses/bindings/courses_binding.dart';
import '../modules/courses/views/courses_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.signup,
      page: () => SignupScreen(),
      binding: SignupScreenBindings(),
    ),
    GetPage(
      name: _Paths.addCourse,
      page: () => AddCourseView(),
      binding: AddCourseBinding(),
    ),
    GetPage(
      name: _Paths.courses,
      page: () => const CoursesView(),
      binding: CoursesBinding(),
    ),
    GetPage(
      name: _Paths.detailCourse,
      page: () => DetailCourseView(),
      binding: DetailCourseBinding(),
    ),
  ];
}
