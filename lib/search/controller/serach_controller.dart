import 'dart:convert';

import 'package:get/get.dart';
import 'package:news_app_task/api/api_data.dart';
import 'package:news_app_task/home/controller/home_controller.dart';
import 'package:news_app_task/model/article_model.dart';
import 'package:news_app_task/services/http_services.dart';
import 'package:news_app_task/widgets/common_snackbar.dart';

class SearchScreenController extends GetxController {
  List<ArticlesModel> searchedData = [];
  bool isLoading = false;
  set _isLoadingState(bool value) {
    isLoading = value;
    update();
  }

  final home = Get.find<HomeController>();
  void serachNews(String text) async {
    try {
      _isLoadingState = true;
      if (home.isConnected) {
        var data = await HTTPServices.instance
            .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
          "apiKey": APIData.apiKey,
          APIData.searchKey: text,
        });

        if (data.statusCode == 200) {
          var decodedData = jsonDecode(data.body);
          List decodedDataList = decodedData['articles'];
          searchedData = home.fetchDataByTab(decodedDataList);
        } else {
          HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
        }
      } else {
        getxErrorSnackbar(
            title: "No internet",
            message: "Pleace check internet connection and try again");
      }

      _isLoadingState = false;
    } catch (e) {
      getxErrorSnackbar(title: "error", message: e.toString());
    }
  }
}
