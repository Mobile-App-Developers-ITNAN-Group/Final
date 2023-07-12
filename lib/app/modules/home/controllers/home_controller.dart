import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../data/models/course_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<CourseModel> allCourses = List<CourseModel>.empty().obs;

  void downloadReport() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("courses").get();

    // reset all courses -> handle the duplicate
    allCourses([]);

    // fill teh data allCourses from database
    for (var element in getData.docs) {
      allCourses.add(CourseModel.fromJson(element.data()));
    }

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData = List.generate(
            allCourses.length,
            (index) {
              CourseModel course = allCourses[index];
              return pw.TableRow(
                children: [
                  // Number
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      "${index + 1}",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  // Course Code
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      course.code,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  // Course Name
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      course.name,
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  // Qty
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(
                      "${course.qty}",
                      textAlign: pw.TextAlign.center,
                      style: const pw.TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  // QR Code
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.BarcodeWidget(
                      color: PdfColor.fromHex("#000000"),
                      barcode: pw.Barcode.qrCode(),
                      data: course.code,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ],
              );
            },
          );

          return [
            pw.Center(
              child: pw.Text(
                "REPORT COURSES",
                textAlign: pw.TextAlign.center,
                style: const pw.TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColor.fromHex("#000000"),
                width: 2,
              ),
              children: [
                pw.TableRow(
                  children: [
                    // No
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        "No",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // course code
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        "Course Code",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // course name
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        "Course Name",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // Qty
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        "Quantity",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    // QR Code
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text(
                        "QR Code",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                ...allData,
              ],
            ),
          ];
        },
      ),
    );

    // simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // memasukan data bytes -> file kosong
    await file.writeAsBytes(bytes);

    // open pdf
    await OpenFile.open(file.path);
  }

  Future<Map<String, dynamic>> getcourseById(String codeBarang) async {
    try {
      var result = await firestore.collection("courses").where("code", isEqualTo: codeBarang).get();

      if (result.docs.isEmpty) {
        return {
          "error": true,
          "message": "Can not found the course.",
        };
      }

      Map<String, dynamic> data = result.docs.first.data();

      return {
        "error": false,
        "message": "Managed to get course details from this course code.",
        "data": CourseModel.fromJson(data),
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Did not get the course details from this course code.",
      };
    }
  }
}
