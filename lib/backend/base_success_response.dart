class BaseSuccessResponse {
  dynamic responsecode;
  dynamic success;
  dynamic message;


  BaseSuccessResponse({this.success, this.message, this.responsecode});

  BaseSuccessResponse.fromJson(Map<String, dynamic> json) {
    responsecode=json['responsecode'];
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['responsecode']=responsecode;
    data['success'] = success;
    data['message'] = message;
    return data;
  }
}
