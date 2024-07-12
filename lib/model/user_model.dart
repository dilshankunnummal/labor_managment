// class UserModel {
//   String? uid;
//   String? userName;
//   String? email;
//   String? password;

//   UserModel(
//       {required this.uid,
//         required this.userName,
//         required this.email,
//         this.password});

//   // receiving data from server

//   factory UserModel.fromMap(map) {
//     return UserModel(
//         uid: map['uid'],
//         userName: map['userName'],
//         email: map['email'],
//         password: map['password']);
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'userName': userName,
//       'email': email,
//       'password': password,
//     };
//   }
// }

class UserModel {
  String? uid;
  String? userName;
  String? email;
  String? password;
  String? phoneNumber;
  String? address;

  UserModel({
    required this.uid,
    required this.userName,
    required this.email,
    this.password,
    required this.phoneNumber,
    required this.address,
  });

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      userName: map['userName'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'userName': userName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'address': address,
    };
  }
}
