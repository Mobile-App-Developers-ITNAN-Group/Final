import 'package:get/get.dart';
import '../view/signup_view.dart';

class SignupScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupScreen>(() => SignupScreen());
  }
}
