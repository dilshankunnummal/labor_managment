// import 'package:cloud_firestore/cloud_firestore.dart';

// class WorkerModel {
//   String? uid;
//   String? userName;
//   String? email;
//   String? password;
//   String? jobType;
//   int? experience;

//   // Define the jobTypes list
//   static final List<String> jobTypes = [
//     "Painter",
//     "Babysitting",
//     "Plumbing",
//     "House Cleaning",
//     "Personal Chef",
//     "Electrecian",
//     "Personal Trainer",
//     "Home Security",
//   ];

//   WorkerModel({
//     required this.uid,
//     required this.userName,
//     required this.email,
//     required this.password,
//     this.jobType,
//     this.experience,
//   });

//   factory WorkerModel.fromJson(Map<String, dynamic> json) {
//     return WorkerModel(
//       uid: json['uid'] ?? '',
//       userName: json['userName'] ?? '',
//       email: json['email'] ?? '',
//       password: json['password'] ?? '',
//       jobType: json['jobType'] ?? '',
//       experience: json['experience'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'userName': userName,
//       'email': email,
//       'password': password,
//       'jobType': jobType,
//       'experience': experience,
//     };
//   }

//   Map<String, dynamic> toJson() => toMap();

//   static fromSnapshot(QueryDocumentSnapshot<Object?> doc) {}
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class WorkerModel {
  String? uid;
  String? userName;
  String? email;
  String? password;
  String? jobType;
  int? experience;
  String? location;

  // Define the jobTypes list
  static final List<String> jobTypes = [
    "Painter",
    "Babysitting",
    "Plumbing",
    "House Cleaning",
    "Personal Chef",
    "Electrician",
    "Personal Trainer",
    "Home Security",
  ];

  WorkerModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.password,
    this.jobType,
    this.experience,
    this.location,
  });

  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
      uid: json['uid'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      jobType: json['jobType'] ?? '',
      experience: json['experience'] ?? 0,
      location: json['location'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'password': password,
      'jobType': jobType,
      'experience': experience,
      'location': location,
    };
  }

  Map<String, dynamic> toJson() => toMap();

  static fromSnapshot(QueryDocumentSnapshot<Object?> doc) {}
}
