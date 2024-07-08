class ServantModel {
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

  ServantModel({
    required this.uid,
    required this.userName,
    required this.email,
    required this.password,
    this.jobType,
    this.experience,
  });

  factory ServantModel.fromJson(Map<String, dynamic> json) {
    return ServantModel(
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
