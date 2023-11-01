import 'dart:convert';

RegistrationRequest registrationRequestFromJson(String str) =>
    RegistrationRequest.fromJson(json.decode(str));

String registrationRequestToJson(RegistrationRequest data) =>
    json.encode(data.toJson());

class RegistrationRequest {
  String firstName;
  String lastName;
  String email;
  String civilStatus;
  String phoneNumber;
  String birthPlace;
  String occupation;
  String gender;
  String dob;
  String postalCode;
  String permanentAddress;
  String password;

  RegistrationRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.civilStatus,
    required this.phoneNumber,
    required this.birthPlace,
    required this.occupation,
    required this.gender,
    required this.dob,
    required this.postalCode,
    required this.permanentAddress,
    required this.password,
  });

  factory RegistrationRequest.fromJson(Map<String, dynamic> json) =>
      RegistrationRequest(
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        civilStatus: json["civilStatus"],
        phoneNumber: json["phoneNumber"],
        birthPlace: json["birthPlace"],
        occupation: json["occupation"],
        gender: json["gender"],
        dob: (json["dob"]),
        postalCode: json["postalCode"],
        permanentAddress: json["permanentAddress"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "civilStatus": civilStatus,
        "phoneNumber": phoneNumber,
        "birthPlace": birthPlace,
        "occupation": occupation,
        "gender": gender,
        "dob": dob,
        "postalCode": postalCode,
        "permanentAddress": permanentAddress,
        "password": password,
      };
}
