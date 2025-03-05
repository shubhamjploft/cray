
import 'dart:convert';

ScreenQuestionResponse screenQuestionResponseFromJson(String str) => ScreenQuestionResponse.fromJson(json.decode(str));

String screenQuestionResponseToJson(ScreenQuestionResponse data) => json.encode(data.toJson());

class ScreenQuestionResponse {
  bool? success;
  String? message;
  int? totalQuestions;
  String? userId;
  String? partnerId;
  String? testId;
  List<ScreenQuestion>? data;

  ScreenQuestionResponse({
    this.success,
    this.message,
    this.totalQuestions,
    this.userId,
    this.partnerId,
    this.testId,
    this.data,
  });

  factory ScreenQuestionResponse.fromJson(Map<String, dynamic> json) => ScreenQuestionResponse(
    success: json["success"],
    message: json["message"],
    totalQuestions: json["totalQuestions"],
    userId: json["userId"],
    partnerId: json["partnerId"],
    testId: json["testId"],
    data: json["data"] == null ? [] : List<ScreenQuestion>.from(json["data"]!.map((x) => ScreenQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "totalQuestions": totalQuestions,
    "userId": userId,
    "partnerId": partnerId,
    "testId": testId,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ScreenQuestion {
  String? id;
  String? question;
  bool? isActive;
  int? marks;
  String? explanation;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ScreenQuestion({
    this.id,
    this.question,
    this.isActive,
    this.marks,
    this.explanation,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory ScreenQuestion.fromJson(Map<String, dynamic> json) => ScreenQuestion(
    id: json["_id"],
    question: json["question"],
    isActive: json["isActive"],
    marks: json["marks"],
    explanation: json["explanation"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "question": question,
    "isActive": isActive,
    "marks": marks,
    "explanation": explanation,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
