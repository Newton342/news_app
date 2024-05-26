import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app_task/widgets/common_snackbar.dart';

class HTTPServices {
  static HTTPServices get instance => HTTPServices();

  final String _domain = "newsapi.org";

  Future<http.Response> getDataFromApi(String api,
      {Map<String, dynamic>? parameters}) async {
    Uri url = Uri.https(_domain, api, parameters);
    var response = await http.get(url);
    return response;
  }

  void apiHandler(int statusCode, {required String data}) {
    var decodedData = jsonDecode(data);
    switch (statusCode) {
      case 400:
        getxErrorSnackbar(
            title: decodedData['status'], message: decodedData['message']);
        break;
      case 401:
        getxErrorSnackbar(
            title: decodedData['status'], message: decodedData['message']);
        break;
      case 426:
        getxErrorSnackbar(
            title: decodedData['status'], message: decodedData['message']);
        break;
      case 429:
        getxErrorSnackbar(
            title: decodedData['status'], message: decodedData['message']);
        break;
      case 500:
        getxErrorSnackbar(
            title: decodedData['status'], message: decodedData['message']);
        break;
      default:
        print("Success code______> $statusCode");
        break;
    }
  }
}
