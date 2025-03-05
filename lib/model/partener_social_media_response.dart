import 'dart:convert';

PartnerSocialMediaResponse partnerSocialMediaResponseFromJson(String str) => PartnerSocialMediaResponse.fromJson(json.decode(str));

String partnerSocialMediaResponseToJson(PartnerSocialMediaResponse data) => json.encode(data.toJson());

class PartnerSocialMediaResponse {
  bool? success;
  String? message;
  Data? data;

  PartnerSocialMediaResponse({
    this.success,
    this.message,
    this.data,
  });

  factory PartnerSocialMediaResponse.fromJson(Map<String, dynamic> json) => PartnerSocialMediaResponse(
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
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? mobileNumber;
  String? age;
  String? profilePicture;
  String? role;
  bool? isActive;
  bool? isBlocked;
  String? ethnicity;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? facebookProfile;
  String? linkedinProfile;

  Data({
    this.id,
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNumber,
    this.age,
    this.profilePicture,
    this.role,
    this.isActive,
    this.isBlocked,
    this.ethnicity,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.facebookProfile,
    this.linkedinProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["_id"],
    userId: json["userId"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNumber: json["mobileNumber"],
    age: json["age"],
    profilePicture: json["profilePicture"],
    role: json["role"],
    isActive: json["isActive"],
    isBlocked: json["isBlocked"],
    ethnicity: json["ethnicity"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    facebookProfile: json["facebookProfile"],
    linkedinProfile: json["linkedinProfile"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobileNumber": mobileNumber,
    "age": age,
    "profilePicture": profilePicture,
    "role": role,
    "isActive": isActive,
    "isBlocked": isBlocked,
    "ethnicity": ethnicity,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "facebookProfile": facebookProfile,
    "linkedinProfile": linkedinProfile,
  };
}
