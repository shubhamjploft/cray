// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) => json.encode(data.toJson());

class GetProfileResponse {
  bool? success;
  String? message;
  ProfileData? data;

  GetProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  factory GetProfileResponse.fromJson(Map<String, dynamic> json) => GetProfileResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileData {
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
  String? otp;
  dynamic otpExpiration;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? facebookProfile;
  String? linkedinProfile;
  String? profilePicture;

  ProfileData({
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
    this.profilePicture,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
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
    profilePicture: json["profilePicture"],
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
    "profilePicture": profilePicture,
  };
}
