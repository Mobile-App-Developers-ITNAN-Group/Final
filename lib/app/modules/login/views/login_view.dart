import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../signup/view/signup_view.dart';
//import '../../signup/controllers/signup_controllers.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  final AuthController authC = Get.find<AuthController>();

  void navigateToSignup() {
    Get.to(() => SignupScreen());
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOGIN'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: emailC,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => TextField(
              autocorrect: false,
              controller: passC,
              keyboardType: TextInputType.text,
              obscureText: controller.isHidden.value,
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.isHidden.toggle();
                  },
                  icon: Icon(
                    controller.isHidden.isFalse ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> result = await authC.login(emailC.text, passC.text);
                  controller.isLoading(false);

                  if (result["error"] == true) {
                    Get.snackbar("Error", result["message"]);
                  } else {
                    Get.offAllNamed(Routes.home);
                  }
                } else {
                  Get.snackbar("Error", "You have to enter your Email and password");
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
              () => Text(controller.isLoading.isFalse ? "LOGIN" : "LOADING..."),
            ),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: navigateToSignup,
            child: const Text(
              'Signup Here',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
