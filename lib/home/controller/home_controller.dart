import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:news_app_task/api/api_data.dart';
import 'package:news_app_task/data/getbuilder_ids.dart';
import 'package:news_app_task/model/article_model.dart';
import 'package:news_app_task/services/http_services.dart';
import 'package:news_app_task/widgets/common_snackbar.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late final TabController tabController;
  int selectedIndex = 0;
  List<ArticlesModel> allNewsData = [];
  List<ArticlesModel> topHeadLineData = [];
  List<ArticlesModel> sportsData = [];
  List<ArticlesModel> entertainmentData = [];
  List<ArticlesModel> electionData = [];
  List<ArticlesModel> stockMarketData = [];
  int _tab1page = 1; //All news tab
  int _tab2page = 1; //Top headlines tab
  int _tab3page = 1; //Sports tab
  int _tab4page = 1; //Entertainment tab
  int _tab5page = 1; //Election tab
  int _tab6page = 1; //Stock market tab
  RxBool isDarkTheme = false.obs;
  bool isLoadingAllNews = false;
  bool isLoadingTopHeadline = false;
  bool isLoadingSport = false;
  bool isLoadingEntertainment = false;
  bool isLoadingElection = false;
  bool isLoadingStockMarket = false;
  set _allNewsState(bool value) {
    isLoadingAllNews = value;
    update([GetBuilderId.allNews]);
  }

  set _topHeadlineState(bool value) {
    isLoadingTopHeadline = value;
    update([GetBuilderId.topHeadline]);
  }

  set _sportState(bool value) {
    isLoadingSport = value;
    update([GetBuilderId.sport]);
  }

  set _entertainmentState(bool value) {
    isLoadingEntertainment = value;
    update([GetBuilderId.entertainment]);
  }

  set _electionState(bool value) {
    isLoadingElection = value;
    update([GetBuilderId.election]);
  }

  set _stockMarket(bool value) {
    isLoadingStockMarket = value;
    update([GetBuilderId.stockMarket]);
  }

  final List<String> homeTab = [
    "All news",
    "Top Headlines",
    "Sports",
    "Entertainment",
    "Election",
    "Stock Market"
  ];
  bool isConnected = false;
  final _internetConnectionChecker = InternetConnectionChecker();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: homeTab.length, vsync: this);
    realTimeConnectionStatue();
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }

  //
  // void checkInternetConnection() async {
  //   bool result = await _internetConnectionChecker.hasConnection;
  //   isConnected = result;
  //   if (result) {
  //     _initializeArticles();
  //   } else {
  //     update(GetBuilderId.allTab);
  //   }
  // }

  void _initializeArticles() {
    getAllNewsData();
    getTopHeadlineData();
    getSportData();
    getEntertainmentData();
    getElectionData();
    getStockMarketData();
  }

  void realTimeConnectionStatue() async {
    _internetConnectionChecker.onStatusChange
        .listen((InternetConnectionStatus event) {
      print(event);
      switch (event) {
        case InternetConnectionStatus.connected:
          isConnected = true;
          _initializeArticles();
          print("Internet $isConnected");
          break;
        case InternetConnectionStatus.disconnected:
          isConnected = false;
          getxErrorSnackbar(title: "Opps!", message: "No internet connection");
          print('You are disconnected from the internet.');
          break;
      }
    });
  }

  void toggleThemeBrightness(bool value) async {
    isDarkTheme(value);
    if (isDarkTheme.value) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
  }

  List<ArticlesModel> fetchDataByTab(List data) {
    return data.map<ArticlesModel>((e) => ArticlesModel.fromJson(e)).toList();
  }

  void getAllNewsData() async {
    try {
      _allNewsState = true;
      var data = await HTTPServices.instance
          .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
        "apiKey": APIData.apiKey,
        APIData.searchKey: homeTab[0].toLowerCase(),
        APIData.pageSizeKey: 10.toString(),
        APIData.pageKey: 1.toString(),
      });

      if (data.statusCode == 200) {
        var decodedData = jsonDecode(data.body);
        List decodedDataList = decodedData['articles'];
        allNewsData = fetchDataByTab(decodedDataList);
      } else {
        HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
      }

      _allNewsState = false;
    } catch (e) {
      getxErrorSnackbar(title: "error", message: e.toString());
    }
  }

  void getTopHeadlineData() async {
    try {
      _topHeadlineState = true;
      var data = await HTTPServices.instance
          .getDataFromApi(APIData.v2 + APIData.topHeadLines, parameters: {
        "apiKey": APIData.apiKey,
        APIData.countryKey: 'in',
        APIData.pageSizeKey: 10.toString(),
        APIData.pageKey: 1.toString(),
      });
      if (data.statusCode == 200) {
        var decodedData = jsonDecode(data.body);
        List decodedDataList = decodedData['articles'];
        topHeadLineData = fetchDataByTab(decodedDataList);
      } else {
        HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
      }
      _topHeadlineState = false;
    } catch (e) {
      getxErrorSnackbar(title: "error", message: e.toString());
    }
  }

  void getSportData() async {
    try {
      _sportState = true;
      var data = await HTTPServices.instance
          .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
        "apiKey": APIData.apiKey,
        APIData.searchKey: homeTab[2].toLowerCase(),
        APIData.pageSizeKey: 10.toString(),
        APIData.pageKey: 1.toString(),
      });

      if (data.statusCode == 200) {
        var decodedData = jsonDecode(data.body);
        List decodedDataList = decodedData['articles'];
        sportsData = fetchDataByTab(decodedDataList);
      } else {
        HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
      }

      _sportState = false;
    } catch (e) {
      getxErrorSnackbar(title: "error", message: e.toString());
    }
  }

  void getEntertainmentData() async {
    try {
      _entertainmentState = true;
      var data = await HTTPServices.instance
          .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
        "apiKey": APIData.apiKey,
        APIData.searchKey: homeTab[3].toLowerCase(),
        APIData.pageSizeKey: 10.toString(),
        APIData.pageKey: 1.toString(),
      });
      if (data.statusCode == 200) {
        var decodedData = jsonDecode(data.body);
        List decodedDataList = decodedData['articles'];
        entertainmentData = fetchDataByTab(decodedDataList);
      } else {
        HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
      }
      _entertainmentState = false;
    } catch (e) {
      getxErrorSnackbar(title: "error", message: e.toString());
    }
  }

  void getElectionData() async {
    try {
      _electionState = true;
      var data = await HTTPServices.instance
          .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
        "apiKey": APIData.apiKey,
        APIData.searchKey: homeTab[4].toLowerCase(),
        APIData.pageSizeKey: 10.toString(),
        APIData.pageKey: 1.toString(),
      });
      if (data.statusCode == 200) {
        var decodedData = jsonDecode(data.body);
        List decodedDataList = decodedData['articles'];
        electionData = fetchDataByTab(decodedDataList);
      } else {
        HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
      }

      _electionState = false;
    } catch (e) {
      getxErrorSnackbar(title: "error", message: e.toString());
    }
  }

  void getStockMarketData() async {
    try {
      _stockMarket = true;
      var data = await HTTPServices.instance
          .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
        "apiKey": APIData.apiKey,
        APIData.searchKey: homeTab[5].toLowerCase(),
        APIData.pageSizeKey: 10.toString(),
        APIData.pageKey: 1.toString(),
      });
      if (data.statusCode == 200) {
        var decodedData = jsonDecode(data.body);
        List decodedDataList = decodedData['articles'];
        stockMarketData = fetchDataByTab(decodedDataList);
      } else {
        HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
      }
      _stockMarket = false;
    } catch (e) {
      getxErrorSnackbar(title: "error", message: e.toString());
    }
  }

//===========Pagination code
  void allNewsPagination() async {
    if (isConnected) {
      bool padeIsLoading = true;
      if (padeIsLoading) {
        _tab1page++;
        padeIsLoading = false;
        var data = await HTTPServices.instance
            .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
          "apiKey": APIData.apiKey,
          APIData.searchKey: homeTab[0].toLowerCase(),
          APIData.pageSizeKey: 10.toString(),
          APIData.pageKey: _tab1page.toString(),
        });
        if (data.statusCode == 200) {
          var decodedData = jsonDecode(data.body);
          List decodedDataList = decodedData['articles'];
          allNewsData.addAll(fetchDataByTab(decodedDataList));
        } else {
          HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
        }
        update([GetBuilderId.allNews]);
        padeIsLoading = true;
      }
    }
  }

  void topHeadlinePagination() async {
    if (isConnected) {
      bool padeIsLoading = true;
      if (padeIsLoading) {
        _tab2page++;
        padeIsLoading = false;
        var data = await HTTPServices.instance
            .getDataFromApi(APIData.v2 + APIData.topHeadLines, parameters: {
          "apiKey": APIData.apiKey,
          APIData.countryKey: 'in',
          APIData.pageSizeKey: 10.toString(),
          APIData.pageKey: _tab2page.toString(),
        });
        if (data.statusCode == 200) {
          var decodedData = jsonDecode(data.body);
          List decodedDataList = decodedData['articles'];
          topHeadLineData.addAll(fetchDataByTab(decodedDataList));
        } else {
          HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
        }
        update([GetBuilderId.topHeadline]);
        padeIsLoading = true;
      }
    }
  }

  void sportPagination() async {
    if (isConnected) {
      bool padeIsLoading = true;
      if (padeIsLoading) {
        _tab3page++;
        padeIsLoading = false;
        var data = await HTTPServices.instance
            .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
          "apiKey": APIData.apiKey,
          APIData.searchKey: homeTab[2].toLowerCase(),
          APIData.pageSizeKey: 10.toString(),
          APIData.pageKey: _tab3page.toString(),
        });
        if (data.statusCode == 200) {
          var decodedData = jsonDecode(data.body);
          List decodedDataList = decodedData['articles'];
          sportsData.addAll(fetchDataByTab(decodedDataList));
        } else {
          HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
        }
        update([GetBuilderId.sport]);
        padeIsLoading = true;
      }
    }
  }

  void entertainmentPagination() async {
    if (isConnected) {
      bool padeIsLoading = true;
      if (padeIsLoading) {
        _tab4page++;
        padeIsLoading = false;
        var data = await HTTPServices.instance
            .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
          "apiKey": APIData.apiKey,
          APIData.searchKey: homeTab[3].toLowerCase(),
          APIData.pageSizeKey: 10.toString(),
          APIData.pageKey: _tab4page.toString(),
        });
        if (data.statusCode == 200) {
          var decodedData = jsonDecode(data.body);
          List decodedDataList = decodedData['articles'];
          entertainmentData.addAll(fetchDataByTab(decodedDataList));
        } else {
          HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
        }
        update([GetBuilderId.entertainment]);
        padeIsLoading = true;
      }
    }
  }

  void electionPagination() async {
    if (isConnected) {
      bool padeIsLoading = true;
      if (padeIsLoading) {
        _tab5page++;
        padeIsLoading = false;
        var data = await HTTPServices.instance
            .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
          "apiKey": APIData.apiKey,
          APIData.searchKey: homeTab[4].toLowerCase(),
          APIData.pageSizeKey: 10.toString(),
          APIData.pageKey: _tab5page.toString(),
        });
        if (data.statusCode == 200) {
          var decodedData = jsonDecode(data.body);
          List decodedDataList = decodedData['articles'];
          electionData.addAll(fetchDataByTab(decodedDataList));
        } else {
          HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
        }
        update([GetBuilderId.election]);
        padeIsLoading = true;
      }
    }
  }

  void stockMarketPagination() async {
    if (isConnected) {
      bool padeIsLoading = true;
      if (padeIsLoading) {
        _tab6page++;
        padeIsLoading = false;
        var data = await HTTPServices.instance
            .getDataFromApi(APIData.v2 + APIData.everything, parameters: {
          "apiKey": APIData.apiKey,
          APIData.searchKey: homeTab[5].toLowerCase(),
          APIData.pageSizeKey: 10.toString(),
          APIData.pageKey: _tab6page.toString(),
        });
        if (data.statusCode == 200) {
          var decodedData = jsonDecode(data.body);
          List decodedDataList = decodedData['articles'];
          stockMarketData.addAll(fetchDataByTab(decodedDataList));
        } else {
          HTTPServices.instance.apiHandler(data.statusCode, data: data.body);
        }
        update([GetBuilderId.stockMarket]);
        padeIsLoading = true;
      }
    }
  }
}
