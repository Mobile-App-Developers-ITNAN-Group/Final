import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:qr_code/app/modules/login/controllers/login_controller.dart';
//import 'package:qr_code/app/modules/login/views/login_view.dart';
import '../controllers/signup_controllers.dart';


class SignupScreen extends StatelessWidget {
  final SignupController _signupController = Get.put(SignupController());

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  SignupScreen({super.key});

  void signUp() {
    String email = _emailController.text;
    String password = _passwordController.text;
    _signupController.signUp(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SIGN UP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
               keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ), 
            const SizedBox(height: 35),
            Obx(() {
              return ElevatedButton(
                onPressed: _signupController.isLoading.value ? null : signUp,
                style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
                child: _signupController.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Sign Up'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
