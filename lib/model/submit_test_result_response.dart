

import 'dart:convert';

SubmitTestResultResponse submitTestResultResponseFromJson(String str) => SubmitTestResultResponse.fromJson(json.decode(str));

String submitTestResultResponseToJson(SubmitTestResultResponse data) => json.encode(data.toJson());

class SubmitTestResultResponse {
  bool? success;
  String? message;
  Data? data;

  SubmitTestResultResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SubmitTestResultResponse.fromJson(Map<String, dynamic> json) => SubmitTestResultResponse(
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
  String? testId;
  int? totalNoOfQuestion;
  int? totalNo;
  int? totalYes;
  int? totalSNotSureQuestions;
  int? totalAttemptedQuestions;
  int? score;
  String? id;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.userId,
    this.testId,
    this.totalNoOfQuestion,
    this.totalNo,
    this.totalYes,
    this.totalSNotSureQuestions,
    this.totalAttemptedQuestions,
    this.score,
    this.id,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    testId: json["testId"],
    totalNoOfQuestion: json["totalNoOfQuestion"],
    totalNo: json["totalNo"],
    totalYes: json["totalYes"],
    totalSNotSureQuestions: json["totalSNotSureQuestions"],
    totalAttemptedQuestions: json["totalAttemptedQuestions"],
    score: json["score"],
    id: json["_id"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "testId": testId,
    "totalNoOfQuestion": totalNoOfQuestion,
    "totalNo": totalNo,
    "totalYes": totalYes,
    "totalSNotSureQuestions": totalSNotSureQuestions,
    "totalAttemptedQuestions": totalAttemptedQuestions,
    "score": score,
    "_id": id,
    "date": date?.toIso8601String(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
