# Group Member
1. Alfikra Muhammad (1836031)
2. Robbani Ghozi Fikri (1832765)

# attendance app
1. github
2. folder management
    - main file = login, sign in, homeview, add course
    - 1 folders
        1. lecturer
3. parts
    1. student
        functions
        - camera for scan
    2. lecturer
        functions
        - generate qr code
        - detele update
4. packages
5. implementation
6. Finish / Report

# ATTENDANCE APP
## INTRODUCTION
The attendance app is a simple application that we built using Flutter. In this application, we added several features such as adding classes, updating classes, deleting, and viewing class details. Then we also added a QR generator that students can access to do their attendance. However, only lecturers can create classes and generate random QRs for that class.

We also definitely apply packages to speed up development, making it more efficient. Several packages such as QR, Flutterfire, and so on. One of the features where lecturers can download a report that contains details about attendance.

However, this application still needs further optimization to be used on a large scale, the use of Authentification from Firebase is also limited to email authentication and there is no feature to send a code to reset users who forget passwords or emails. But this application has successfully run as it should using a simple Firebase database.

## OBJECTIVES
1. Increase Efficiency: The main purpose of this application is to increase efficiency in the attendance process. By using QR scanning, this application allows users to take attendance quickly and accurately, saving time that was previously needed to record attendance manually.

2. Improved Accuracy: The Attendance QR scan application aims to improve accuracy in recording attendance. By using a unique QR code for each class, this application ensures that attendance is recorded correctly, reducing errors and data manipulation.

3. Resource Saving: With the adoption of this application, companies or institutions can save on human resources and paper usage. In the manual process, administrative staff need to record attendance manually and process data. With QR scanning, this process is automated and reduces human involvement, so resources can be allocated to other, more value-added tasks.

4. Improved Security: One of the main goals of this application is to improve security in the attendance process. By using a unique QR code, this application reduces the risk of forgery or identity theft in attendance.

6. Improved Analysis and Reporting: The attendance QR scan App aims to provide better analysis and reporting regarding attendance. With data collected automatically via QR scanning, this application can generate detailed attendance reports and provide valuable insights for users in managing and increasing their attendance.

## FITURES AND FUNCTIONALITIES

1. QR scanning: Lecturers can generate a unique QR that can be scanned by students
2. Class creation: Lecturers can create certain classes and each has a different QR code
3. Update class: Lecturers can update the class they have created (class name, and number of students)
4. Delete class: Lecturer can delete class if needed
5. Download report: Lecturers can download attendance reports so that it is more efficient to collect student attendance data.

+----------------------+             +-----------------------+             +-------------------+
|    User              |             |  Attendance App       |             |   Server          |
+----------------------+             +-----------------------+             +-------------------+
         |                                 |                                 |
         | Login / SignUp                  |                                 |
         |-------------------------------->| Authentification                |
         |                                 |-------------------------------->|
         |                                 |                                 |
         |                                 | Valid                           |
         |                                 |<--------------------------------|
         | Homeview                        |                                 |
         |-------------------------------->|                                 |
         |                                 |                                 |
         | Creating Class                  |                                 |
         |-------------------------------->|                                 |
         |                                 |                                 |
         |                                 | Showing detail of the class     |
         |                                 |-------------------------------->| 
         |                                 |                                 |
         | Generate QR Code                |                                 |
         |-------------------------------->| Validation QR Code              |
         |                                 |-------------------------------->|
         |                                 |                                 |
         |                                 | Checking validity QR Code       |
         |                                 | and attendace data              |
         |                                 |                                 |
         |                                 |                                 |
         |                                 | Send the data to database       |
         |                                 |-------------------------------->|
         |                                 |                                 |
         |                                 |                                 |
         |                                 |                                 |
         | Generate report                 |                                 |
         |<--------------------------------|                                 |
         |                                 |                                 |
         |                                 |                                 |


## REFERENCES

### Packages
1. package:firebase_auth/firebase_auth.dart
2. package:firebase_core/firebase_core.dart
3. package:cloud_firestore/cloud_firestore.dart
4. package:qr_flutter/qr_flutter.dart

### Documentations
1. flutterfire  : https://firebase.google.com/docs/flutter/setup?platform=ios#available-plugins
2. pubdev       : https://pub.dev/
3. Flutter FlutterFire Plugins  : Dr. Muhamad Sadry Abu Seman (Class material)
4. Flutter Packages  Plugins    : Dr. Muhamad Sadry Abu Seman (Class material)