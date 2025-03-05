
import 'dart:convert';

UserSocialMediaResponse userSocialMediaResponseFromJson(String str) => UserSocialMediaResponse.fromJson(json.decode(str));

String userSocialMediaResponseToJson(UserSocialMediaResponse data) => json.encode(data.toJson());

class UserSocialMediaResponse {
  bool? success;
  String? message;
  Data? data;

  UserSocialMediaResponse({
    this.success,
    this.message,
    this.data,
  });

  factory UserSocialMediaResponse.fromJson(Map<String, dynamic> json) => UserSocialMediaResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? password;
  String? role;
  bool? isEmailVerified;
  bool? isActive;
  bool? isBlocked;
  String? subscriptionStatus;
  String? platform;
  dynamic otp;
  dynamic otpExpiration;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? facebookProfile;
  String? linkedinProfile;

  Data({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.password,
    this.role,
    this.isEmailVerified,
    this.isActive,
    this.isBlocked,
    this.subscriptionStatus,
    this.platform,
    this.otp,
    this.otpExpiration,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.facebookProfile,
    this.linkedinProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    password: json["password"],
    role: json["role"],
    isEmailVerified: json["isEmailVerified"],
    isActive: json["isActive"],
    isBlocked: json["isBlocked"],
    subscriptionStatus: json["subscriptionStatus"],
    platform: json["platform"],
    otp: json["otp"],
    otpExpiration: json["otpExpiration"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    facebookProfile: json["facebookProfile"],
    linkedinProfile: json["linkedinProfile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobileNumber": mobileNumber,
    "password": password,
    "role": role,
    "isEmailVerified": isEmailVerified,
    "isActive": isActive,
    "isBlocked": isBlocked,
    "subscriptionStatus": subscriptionStatus,
    "platform": platform,
    "otp": otp,
    "otpExpiration": otpExpiration,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "facebookProfile": facebookProfile,
    "linkedinProfile": linkedinProfile,
  };
}
