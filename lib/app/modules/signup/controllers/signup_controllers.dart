import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    //RxBool isHidden = true.obs;
    RxBool isLoading = false.obs;

  void signUp(String email, String password) async {
    try {
      isLoading.value = true;
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Error',
          'Password is too weak.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Error',
          'Email is already in use.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        } else {
            //Get.offAllNamed(
             // Routes.home);
        } 
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
