
import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? mobileNumber;

  SignUpResponse({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.mobileNumber,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    password: json["password"],
    mobileNumber: json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
    "mobileNumber": mobileNumber,
  };
}
