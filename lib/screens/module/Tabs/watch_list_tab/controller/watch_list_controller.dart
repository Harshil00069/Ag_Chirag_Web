import 'dart:convert';

import 'package:ag_chirag_web/Api/api_implementor.dart';
import 'package:ag_chirag_web/config/config_toast.dart';
import 'package:ag_chirag_web/constant/common_utils.dart';
import 'package:ag_chirag_web/screens/module/Tabs/home_tab/controller/home_tab_controller.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/exchange_list_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/search_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/watch_list_model.dart';
import 'package:ag_chirag_web/utils/app_prefs_manager.dart';
import 'package:get/get.dart';

class WatchListController extends GetxController{

  SearchData? selectedShare;
  RxString selectedShareLotSizes = "".obs;
  List<SearchData> newShareList = [];
  RxBool isLoadingNewSearch = false.obs;
  RxBool isScriptLoading = false.obs;

  // List<WatchListModel> watchlist = [];
  RxList<WatchListModel> watchlist = <WatchListModel>[].obs;
  List<WatchListModel> watchListJsonData = [];
  List<WatchListModel> basketWatchlist = [];
  HomeTabController homeScreenController = Get.put(HomeTabController());
  RxBool watchListDataLoad = false.obs;

  RxList<ExchangeListData> exchangeList = <ExchangeListData>[
    ExchangeListData.fromJson({
      "exchangeName": "Select",
      "shortName": "",}),
    ExchangeListData.fromJson({
      "exchangeName": "NFO",
      "shortName": "1",}),
    ExchangeListData.fromJson({
      "exchangeName": "BSE",
      "shortName": "2",}),
    ExchangeListData.fromJson({
      "exchangeName": "NSE",
      "shortName": "3",}),
  ].obs;

  @override
  void onInit() {
    getWatchListData();
    super.onInit();
  }

  Future<void> getLoadSearchScriptApi() async {
    newShareList.clear();
    isScriptLoading.value = true;
    try {
      final response = await ApiImplementor.loadScriptApiImplementer();
      if (response.success == true) {
        ConfigToast.showToast( message: "Data Loaded Successfully", type: ToastType.success);
      }

      isScriptLoading.value = false;
    } catch (e) {
      ConfigToast.showToast( message: e.toString(), type: ToastType.error);
      isScriptLoading.value = false;
    }
  }

  Future<void> getSearchScriptApi({required String type}) async {
    newShareList.clear();
    isLoadingNewSearch.value = true;
    try {
      final response = await ApiImplementor.searchScriptApiImplementer(type: type);
      if (response.data!.isNotEmpty) {
        newShareList.addAll(response.data??[]);
      }

      isLoadingNewSearch.value = false;
    } catch (e) {
      ConfigToast.showToast( message: e.toString(), type: ToastType.error);
      isLoadingNewSearch.value = false;
    }
  }

  void addToWatchList(WatchListModel watchListModel) {
    List<WatchListModel> watchLst = watchlist
        .where(
            (element) => element.tradingsymbol == watchListModel.tradingsymbol)
        .toList();
    if (watchLst.isEmpty) {
      watchlist.add(watchListModel);
      basketWatchlist.add(watchListModel);
      print("LL=> ${basketWatchlist.length}");
      for (int i = 1; i < basketWatchlist.length; i++) {
        basketWatchlist[i].position = i;
        print("LTT=> ${basketWatchlist[i].lotsize}");
      }
      // Helper().showMessage(message: "Added Successfully");
      ConfigToast.showToast(message: "Added Successfully", type: ToastType.success);
      update();
    } else {
      print("Already present");
    }
  }

  void removeFromWatchList(WatchListModel watchListModel, int pos) async {
    List<WatchListModel> watchListLocal = await SharedPref.getWatchListData();

    for (int i = 0; i < watchlist.length; i++) {
      if (watchListLocal[i].tradingsymbol == watchListModel.tradingsymbol) {
        watchListLocal.removeAt(i);
        watchlist.removeAt(pos);
        basketWatchlist.removeAt(pos + 1);
      }
    }

    List<String> watchListForSp = [];

    for (var item in watchListLocal) {
      watchListForSp.add(json.encode(item.toJson()));
    }

    print("wlist sp :-${watchListForSp}");
    SharedPref.setWatchData(watchListForSp);
    update();
    ConfigToast.showToast(message: "Remove Successfully", type: ToastType.success);
    // Helper().showMessage(message: "Remove Successfully");
  }

  void getWatchListData() {
    watchlist.clear();
    basketWatchlist.clear();
    basketWatchlist.add(WatchListModel(
      lotsize: "0",
      position: 0,
      tradingsymbol: "Select Symbol",
    ));
    SharedPref.getWatchListData().then((value) {
      for (var item in value) {
        addToWatchList(item);
      }
      update();
    });
  }

  void addWatchListJson() {
    watchListJsonData = watchlist.map((e) {
      return WatchListModel(
          exchange: e.exchange,
          tradingsymbol: e.tradingsymbol,
          symboltoken: e.symboltoken);
    }).toList();
  }

  Future<void> getSharePriceApi() async {
    watchListDataLoad.value = true;

    if (homeScreenController.commonClientJsonDataList.isEmpty) {
      // Helper().showMessage(message: "User Not Login");
      return;
    }
    addWatchListJson();
    try {
      final response = await ApiImplementor.getLtpApiImplementer(
          userList: homeScreenController.commonClientJsonDataList,
          ltpList: watchListJsonData);
      if (response.results.isNotEmpty) {
        for (var item in response.results) {
          int pos = watchlist
              .indexWhere((element) => element.symboltoken == item.symboltoken);
          if (pos != -1) {
            watchlist[pos].ltp = item.ltp;
          }
        }
      }
      watchListDataLoad.value = false;
      update();
    } catch (e) {
      watchListDataLoad.value = false;
    }
  }
}