import 'dart:convert';

FilterQuestionResponse filterQuestionResponseFromJson(String str) => FilterQuestionResponse.fromJson(json.decode(str));

String filterQuestionResponseToJson(FilterQuestionResponse data) => json.encode(data.toJson());

class FilterQuestionResponse {
  bool? success;
  String? message;
  int? totalQuestions;
  String? userId;
  String? partnerId;
  String? testId;
  List<QuestionList>? data;

  FilterQuestionResponse({
    this.success,
    this.message,
    this.totalQuestions,
    this.userId,
    this.partnerId,
    this.testId,
    this.data,
  });

  factory FilterQuestionResponse.fromJson(Map<String, dynamic> json) => FilterQuestionResponse(
    success: json["success"],
    message: json["message"],
    totalQuestions: json["totalQuestions"],
    userId: json["userId"],
    partnerId: json["partnerId"],
    testId: json["testId"],
    data: json["data"] == null ? [] : List<QuestionList>.from(json["data"]!.map((x) => QuestionList.fromJson(x))),
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

class QuestionList {
  String? id;
  String? question;
  bool? isActive;
  double? marks;
  String? explanation;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  QuestionList({
    this.id,
    this.question,
    this.isActive,
    this.marks,
    this.explanation,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory QuestionList.fromJson(Map<String, dynamic> json) => QuestionList(
    id: json["_id"],
    question: json["question"],
    isActive: json["isActive"],
    marks: json["marks"]?.toDouble(),
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
