import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_course_controller.dart';

class AddCourseView extends GetView<AddCourseController> {
  AddCourseView({Key? key}) : super(key: key);

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD COURSE'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.text,
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
          //const SizedBox(height: 20),
          //TextField(
          //  autocorrect: false,
          // controller: qtyC,
          //  keyboardType: TextInputType.number,
          //  decoration: InputDecoration(
          //   labelText: "Quantity",
          //    border: OutlineInputBorder(
          //      borderRadius: BorderRadius.circular(9),
          //   ),
          //  ),
          //),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (codeC.text.isNotEmpty && nameC.text.isNotEmpty) { //&& qtyC.text.isNotEmpty
                  controller.isLoading(true);
                  Map<String, dynamic> result = await controller.addCourse({
                    "code": codeC.text,
                    "name": nameC.text,
                    //"qty": int.tryParse(qtyC.text) ?? 0,
                    //"qty": qtyC.text.isNotEmpty ? int.tryParse(qtyC.text) ?? 0 : null,
                  });
                  controller.isLoading(false);

                  Get.back();

                  Get.snackbar(result["error"] == true ? "Error" : "Success", result["message"]);
                } else {
                  Get.snackbar("Error", "All the data must filled.");
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
              () => Text(controller.isLoading.isFalse ? "ADD COURSE" : "LOADING..."),
            ),
          ),
        ],
      ),
    );
  }
}
