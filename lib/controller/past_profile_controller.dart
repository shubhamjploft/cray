import 'package:cray/backend/api_end_points.dart';
import 'package:cray/backend/base_api_service.dart';
import 'package:cray/model/user_past_profile_response.dart';
import 'package:cray/utils/base_functions.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PastProfileController extends GetxController{

  final RxList<PastProfileData> pastProfileDataList = <PastProfileData>[].obs;
  RefreshController refreshController = RefreshController(initialRefresh: false);

//user id send in param

  Future<void> userPastProfile({bool isLoaderShow = true,
       required dynamic userId,}) async {
  String url= "${ApiEndPoints().userPastProfileApi}/$userId";
    try {
      var value = await BaseApiService()
          .get(apiEndPoint: url, showLoader: isLoaderShow);

      if (value?.statusCode == 200) {
        UserPastProfileResponse response = UserPastProfileResponse.fromJson(value?.data);
        if (response.success ?? false) {
          pastProfileDataList.value = response.data ?? [];
        } else {
          showSnackBar(subtitle: response.message ?? "");
        }
      } else {
        showSnackBar(subtitle: "Something went wrong, please try again");
      }
    } catch (e) {
      showSnackBar(subtitle: "An error occurred. Please try again.");
    } finally {
      refreshController.refreshCompleted();
      update();
    }
  }

}