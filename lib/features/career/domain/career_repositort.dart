import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../../../api/api_client.dart';

class CareerRepo extends GetxService {
  final ApiClient apiClient;

  CareerRepo({required this.apiClient});

  Future<Response> getJobRoleList() async {
    return await apiClient.getData(AppConstants.jobRoleListUri);
  }

  Future<Response> submitCareer(var body, XFile? data) async {
    return await apiClient.postMultipartData(
        AppConstants.careerApplyUri, body, [MultipartBody('cv', data)]);
  }
}
