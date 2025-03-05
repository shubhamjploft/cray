// To parse this JSON data, do
//
//     final submitQuestionResponse = submitQuestionResponseFromJson(jsonString);

import 'dart:convert';

SubmitQuestionResponse submitQuestionResponseFromJson(String str) => SubmitQuestionResponse.fromJson(json.decode(str));

String submitQuestionResponseToJson(SubmitQuestionResponse data) => json.encode(data.toJson());

class SubmitQuestionResponse {
  bool? success;
  String? message;
  Data? data;

  SubmitQuestionResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SubmitQuestionResponse.fromJson(Map<String, dynamic> json) => SubmitQuestionResponse(
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
  String? userId;
  String? partnerId;
  String? questionId;
  String? userAnswer;
  bool? isUsed;
  String? testId;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.userId,
    this.partnerId,
    this.questionId,
    this.userAnswer,
    this.isUsed,
    this.testId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    partnerId: json["partnerId"],
    questionId: json["questionId"],
    userAnswer: json["userAnswer"],
    isUsed: json["isUsed"],
    testId: json["testId"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "partnerId": partnerId,
    "questionId": questionId,
    "userAnswer": userAnswer,
    "isUsed": isUsed,
    "testId": testId,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
