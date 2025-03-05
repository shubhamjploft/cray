
class ApiEndPoints {
  /// Debug Server: https://v4.checkprojectstatus.com/water/api/
  final String baseUrl = 'https://stage.tasksplan.com:5152/api/v1/';
  static String imagePathUrl = 'https://stage.tasksplan.com:5152/assets/profile_pictures/';

  /// Auth EndPoints
  final String userLoginApi = "user/login";
  final String userSignUpApi = "user/signup";
  final String otpVerifyApi = "user/verify-otp";
  final String emailResendApi = "user/resend-otp";
  final String forgotPasswordApi = "user/forgotPassword";
  final String changePasswordApi = "user/resetPassword";
  final String userAddAccountApi = "user/addAccount";
  final String partnerDetailApi = "partner/addPartner";
  final String partnerSocialAccountApi = "partner/addSocialAccount";
  final String userPastProfileApi = "user/pastprofile";
  final String userEditProfileApi = "user/editProfile";
  final String getUserProfileApi = "user/myProfile";
  final String filterQuestionsApi = "question/filterQuestions";
  final String submitQuesrtionApi = "question/submitQuesrtion";
  final String submitTestResultApi = "question/submitTestResult";
  final String viewReportApi = "question/examRecord";
  final String filterScreeningQuestionApi = "screenquestion/filterScreeningQuestion";

}
