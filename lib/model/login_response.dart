import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  String? message;
  User? user;
  String? token;
  bool? success;

  LoginResponse({
    this.message,
    this.user,
    this.token,
    this.success,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    message: json["message"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "user": user?.toJson(),
    "token": token,
    "success": success,
  };
}

class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? role;
  bool? isActive;
  bool? isBlocked;
  bool? isEmailVerified;
  String? mobileNumber;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.role,
    this.isActive,
    this.isBlocked,
    this.isEmailVerified,
    this.mobileNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    role: json["role"],
    isActive: json["isActive"],
    isBlocked: json["isBlocked"],
    isEmailVerified: json["isEmailVerified"],
    mobileNumber: json["mobileNumber"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "role": role,
    "isActive": isActive,
    "isBlocked": isBlocked,
    "isEmailVerified": isEmailVerified,
    "mobileNumber": mobileNumber,
  };
}
