class CourseModel {
  CourseModel({
    required this.code,
    required this.name,
    required this.courseId,
    required this.qty,
  });

  final String code;
  final String name;
  final String courseId;
  final int qty;

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        code: json["code"] ?? "",
        name: json["name"] ?? "",
        courseId: json["courseId"] ?? "",
        qty: json["qty"] ?? 0,
      );

  get att => null;

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "courseId": courseId,
        "qty": qty,
      };
}
