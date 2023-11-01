import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String accessToken;
  User user;

  LoginResponse({
    required this.accessToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["access_token"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "user": user.toJson(),
      };
}

class User {
  String userId;
  String email;
  String role;
  DateTime createdDate;
  DateTime lastLoginDate;
  DateTime passwordExpiryDate;
  bool isLocked;
  String lastLoginIp;
  String firstName;
  String lastName;
  String civilStatus;
  String phoneNumber;
  String birthPlace;
  String occupation;
  String gender;
  DateTime dob;
  String postalCode;
  String permanentAddress;

  User({
    required this.userId,
    required this.email,
    required this.role,
    required this.createdDate,
    required this.lastLoginDate,
    required this.passwordExpiryDate,
    required this.isLocked,
    required this.lastLoginIp,
    required this.firstName,
    required this.lastName,
    required this.civilStatus,
    required this.phoneNumber,
    required this.birthPlace,
    required this.occupation,
    required this.gender,
    required this.dob,
    required this.postalCode,
    required this.permanentAddress,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["userId"],
        email: json["email"],
        role: json["role"],
        createdDate: DateTime.parse(json["createdDate"]),
        lastLoginDate: DateTime.parse(json["lastLoginDate"]),
        passwordExpiryDate: DateTime.parse(json["passwordExpiryDate"]),
        isLocked: json["isLocked"],
        lastLoginIp: json["lastLoginIP"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        civilStatus: json["civilStatus"],
        phoneNumber: json["phoneNumber"],
        birthPlace: json["birthPlace"],
        occupation: json["occupation"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        postalCode: json["postalCode"],
        permanentAddress: json["permanentAddress"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "email": email,
        "role": role,
        "createdDate": createdDate.toIso8601String(),
        "lastLoginDate": lastLoginDate.toIso8601String(),
        "passwordExpiryDate": passwordExpiryDate.toIso8601String(),
        "isLocked": isLocked,
        "lastLoginIP": lastLoginIp,
        "firstName": firstName,
        "lastName": lastName,
        "civilStatus": civilStatus,
        "phoneNumber": phoneNumber,
        "birthPlace": birthPlace,
        "occupation": occupation,
        "gender": gender,
        "dob": dob.toIso8601String(),
        "postalCode": postalCode,
        "permanentAddress": permanentAddress,
      };
}

