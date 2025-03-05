import 'dart:convert';

ExamRecordReviewResponse examRecordReviewResponseFromJson(String str) => ExamRecordReviewResponse.fromJson(json.decode(str));

String examRecordReviewResponseToJson(ExamRecordReviewResponse data) => json.encode(data.toJson());

class ExamRecordReviewResponse {
  bool? success;
  String? message;
  Data? data;

  ExamRecordReviewResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ExamRecordReviewResponse.fromJson(Map<String, dynamic> json) => ExamRecordReviewResponse(
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
  String? testId;
  List<Question>? questions;

  Data({
    this.testId,
    this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    testId: json["testId"],
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "testId": testId,
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  String? questionId;
  String? question;
  String? userSelectedOption;
  bool? isUsed;
  String? explanation;

  Question({
    this.questionId,
    this.question,
    this.userSelectedOption,
    this.isUsed,
    this.explanation,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    questionId: json["questionId"],
    question: json["question"],
    userSelectedOption: json["userSelectedOption"],
    isUsed: json["isUsed"],
    explanation: json["explanation"],
  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "question": question,
    "userSelectedOption": userSelectedOption,
    "isUsed": isUsed,
    "explanation": explanation,
  };
}
