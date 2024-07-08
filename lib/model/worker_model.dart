<<<<<<< HEAD
class WorkerModel {
=======
class ServantModel {
>>>>>>> b1d7e2e76214bf0dbf77f1db3096030a71b2a9fd
  String? uid;
  String? userName;
  String? email;
  String? password;
  String? jobType;
  int? experience;

  // Define the jobTypes list
  static final List<String> jobTypes = [
    "Painter",
    "Gardening",
    "Babysitting",
    "Plumbing",
    "House Cleaning",
    "Personal Chef",
    "Electrecian",
    "Personal Trainer",
    "Home Security",
  ];

<<<<<<< HEAD
  WorkerModel({
=======
  ServantModel({
>>>>>>> b1d7e2e76214bf0dbf77f1db3096030a71b2a9fd
    required this.uid,
    required this.userName,
    required this.email,
    required this.password,
    this.jobType,
    this.experience,
  });

<<<<<<< HEAD
  factory WorkerModel.fromJson(Map<String, dynamic> json) {
    return WorkerModel(
=======
  factory ServantModel.fromJson(Map<String, dynamic> json) {
    return ServantModel(
>>>>>>> b1d7e2e76214bf0dbf77f1db3096030a71b2a9fd
      uid: json['uid'] ?? '',
      userName: json['userName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      jobType: json['jobType'] ?? '',
      experience: json['experience'] ?? 0,
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
    };
  }

  Map<String, dynamic> toJson() => toMap();
}
