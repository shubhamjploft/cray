import 'dart:developer';
import 'package:cray/UI/screens/allyes_question_screen.dart';
import 'package:cray/UI/screens/profile_match_screen.dart';
import 'package:cray/UI/screens/view_report_screen.dart';
import 'package:cray/UI/swipe_screen/question_screen.dart';
import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/controller/swipeable_cards_controller.dart';
import 'package:cray/model/exam_record_review_response.dart';
import 'package:cray/model/filter_question_response.dart';
import 'package:cray/model/screen_question_response.dart';
import 'package:cray/model/submit_question_response.dart';
import 'package:cray/model/submit_test_result_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class QuestionScreenController extends GetxController {
  RxInt currentProgress = 1.obs;
  RxInt totalProgress = 42.obs;

  Rx<SwipeableCardSectionController> cardController = SwipeableCardSectionController().obs;

  RxDouble progress = 0.0.obs;

  RxBool isLeft = false.obs;
  RxBool isRight = false.obs;
  RxBool isDown = false.obs;

  void updateProgress() {
    double total = totalProgress.value.toDouble();
    progress.value = currentProgress.value / total;
  }

  void likeFeed({bool? isAllNo}) {
    if (isAllNo ?? false) {
      allQuestionList.removeAt(0);
      allQuestionList.refresh();
    } else {
      screenQuestionList.removeAt(0);
      screenQuestionList.refresh();
    }
    updateProgress();
    update();
    log("FEED LIST LENGTH------->>>>>> ${allQuestionList.length}");
  }

  //first time hit  five question  Api

  final RxList<ScreenQuestion> screenQuestionList = <ScreenQuestion>[].obs;

  Future<void> screenquestion({required String partId}) async {
    try {
       dynamic value = await BaseApiService().get(
        apiEndPoint: '${ApiEndPoints().filterScreeningQuestionApi}/$partId',
      );
      if (value?.statusCode == 200) {
        ScreenQuestionResponse response = ScreenQuestionResponse.fromJson(value?.data);
        if (response.success ?? false) {
          screenQuestionList.value = response.data ?? [];
          totalProgress.value = 0;
          totalProgress.value = (response.data ?? []).length;
          partnerId.value = response.partnerId?.toString() ?? "";
          testId.value = response.testId?.toString() ?? "";
          userId.value = response.userId?.toString() ?? "";
          Get.to(() => const QuestionScreen());
        } else {
          showSnackBar(subtitle: response.message ?? "",
          );
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    } catch (e) {
      showSnackBar(subtitle: "An error occurred. Please try again.");
    }
  }

  //Filter question Api second time hit the Api

  final RxList<QuestionList> allQuestionList = <QuestionList>[].obs;
  RxString testId = ''.obs;
  RxString partnerId = ''.obs;
  RxString userId = ''.obs;

  Future<void> filterQuestionApi({required String partId}) async {
    Map<String, String> data = {
      "questionCount": "14",
      "partnerId": partId,
    };
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().filterQuestionsApi, data: data)
        .then((dynamic value) {
      if (value?.statusCode == 200) {
        try {
          FilterQuestionResponse response = FilterQuestionResponse.fromJson(value?.data);
          if (response.success ?? false) {
            allQuestionList.value = response.data ?? [];
            totalProgress.value = 0;
            totalProgress.value = (response.data ?? []).length;
            partnerId.value = response.partnerId?.toString() ?? "";
            testId.value = response.testId?.toString() ?? "";
            userId.value = response.userId?.toString() ?? "";
            // Get.back();
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

  //Submit question Api yes,no,notSure

  Future<void> submitQuestionApi({required String questionId, required String userSelectedOption, bool? isAllNo}) async {
    Map<String, String> data = {
      "questionId": questionId,
      "testId": testId.value,
      "userSelectedOption": userSelectedOption,
      "userId": userId.value,
      "partnerId": partnerId.value,
    };
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().submitQuesrtionApi, data: data)
        .then((dynamic value) {
      if (value?.statusCode == 200) {
        try {
          SubmitQuestionResponse response =
              SubmitQuestionResponse.fromJson(value?.data);
          if (response.success ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            likeFeed(isAllNo: isAllNo);
            if (isAllNo ?? false) {
              if (allQuestionList.isEmpty) {
                submitTestResultApi(isAllNo: isAllNo);
              }
            } else {
              if (screenQuestionList.isEmpty) {
                submitTestResultApi(isAllNo: isAllNo);
              }
            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

  // Submit test result Api lastQuestion attempt hit this api

  Future<void> submitTestResultApi({bool? isAllNo}) async {
    Map<String, String> data = {
      "testId": testId.value,
      "partnerId": partnerId.value,
    };
    await BaseApiService()
        .post(apiEndPoint: ApiEndPoints().submitTestResultApi, data: data)
        .then((dynamic value) async {
      if (value?.statusCode == 200) {
        try {
          SubmitTestResultResponse response =
              SubmitTestResultResponse.fromJson(value?.data);
          if (response.success ?? false) {
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
            if (isAllNo ?? false) {
              if ((int.tryParse(response.data?.score?.toString() ?? "0") ?? 0) >
                  0) {
                Get.to(() => ProfileMatchScreen(
                      score: response.data?.score?.toString() ?? "",
                    ));
              }

              /// after five question
            } else {
              if ((int.tryParse(response.data?.totalYes?.toString() ?? "0") ??
                      0) >
                  0) {
                Get.to(() => AllYesQuestionScreen(partnerId: partnerId.value));
                // Get.to(() =>  StartAssessmentScreen(partnerId:partnerId.value));
              } else {
                await filterQuestionApi(partId: partnerId.value);
                Get.back();
                Get.to(() => const QuestionScreen(isAllNo: true,));
              }
            }
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      update();
    });
  }

  //View report question Api

  final RxList<Question> viewQuestionList = <Question>[].obs;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  Future<void> viewReportQuestionApi({
    bool isLoaderShow = true,
  }) async {
    Map<String, String> data = {
      "testId": testId.value,
    };
    await BaseApiService()
        .post(
            apiEndPoint: ApiEndPoints().viewReportApi,
            data: data,
            showLoader: isLoaderShow)
        .then((dynamic value) {
      if (value?.statusCode == 200) {
        try {
          ExamRecordReviewResponse response =
              ExamRecordReviewResponse.fromJson(value?.data);
          if (response.success ?? false) {
            viewQuestionList.value = (response.data?.questions ?? []);
            Get.to(() => const ViewReportScreen());
            // showSnackBar(subtitle: response.message ?? "", isSuccess: true);
          } else {
            showSnackBar(subtitle: response.message ?? "");
          }
        } catch (e) {
          showSnackBar(subtitle: parsingError);
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
      refreshController.refreshCompleted();
      update();
    });
  }
}
