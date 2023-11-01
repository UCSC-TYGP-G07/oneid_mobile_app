import 'dart:convert';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String accessToken;
  String email;

  LoginResponse({
    required this.accessToken,
    required this.email,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json["access_token"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "email": email,
      };
}
