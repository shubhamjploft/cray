import 'dart:convert';

UserPastProfileResponse userPastProfileResponseFromJson(String str) => UserPastProfileResponse.fromJson(json.decode(str));

String userPastProfileResponseToJson(UserPastProfileResponse data) => json.encode(data.toJson());

class UserPastProfileResponse {
  bool? success;
  String? message;
  List<PastProfileData>? data;

  UserPastProfileResponse({
    this.success,
    this.message,
    this.data,
  });

  factory UserPastProfileResponse.fromJson(Map<String, dynamic> json) => UserPastProfileResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<PastProfileData>.from(json["data"]!.map((x) => PastProfileData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class PastProfileData {
  String? name;
  String? score;
  String? lastUpdate;
  String? createdAt;

  PastProfileData({
    this.name,
    this.score,
    this.lastUpdate,
    this.createdAt,
  });

  factory PastProfileData.fromJson(Map<String, dynamic> json) => PastProfileData(
    name: json["name"],
    score: json["score"],
    lastUpdate: json["lastUpdate"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "score": score,
    "lastUpdate": lastUpdate,
    "createdAt": createdAt,
  };
}
