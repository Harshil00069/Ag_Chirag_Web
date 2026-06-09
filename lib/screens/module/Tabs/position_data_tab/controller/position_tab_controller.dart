import 'package:ag_chirag_web/Api/api_implementor.dart';
import 'package:ag_chirag_web/screens/module/Tabs/home_tab/controller/home_tab_controller.dart';
import 'package:ag_chirag_web/screens/module/Tabs/position_data_tab/model/place_order_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/position_data_tab/model/position_data_model.dart';
import 'package:get/get.dart';

class PositionTabController extends GetxController{

  HomeTabController homeScreenController = Get.put(HomeTabController());
  List<PositionData> commonOrderList = [];
  RxList<PositionData> positionList = <PositionData>[].obs;
  List <String?> commandata =[];
  RxBool isDataLoading = false.obs;
  RxBool isPlaceOrderLoading = false.obs;
  List<PlaceOrderModel> placeOrderList = [];

  Future<void> getPositionList() async {
    positionList.clear();
    isDataLoading.value = true;
    try {
      var response = await ApiImplementor.getPositionApiImplementer(userList: homeScreenController.commonClientJsonDataList);
      if (response.results.isNotEmpty) {
        for(int i=0; i<response.results.length;i++){
          positionList.addAll(response.results[i].data);
        }
        for(int k = 0;k<positionList.length;k++){
          int index =  homeScreenController.usersList.indexWhere((data)=> data.clientcode == positionList[k].client);

          if (index != -1) {
            // 3. Extract the name from your user object
            positionList[k].clientName = homeScreenController.usersList[index].username??""; // Change '.name' to whatever your property is called (e.g., clientName)
            // print("Found Client Name: ${orderList[k].clientName}");
          }
        }

        update();
      }
    } catch (e) {
      print("${e}");
    } finally {
      isDataLoading.value = false;
    }
  }


  Future<void> getPlaceOrdersApi({required List placeOderList, required bool isBasketOrder}) async {
    isPlaceOrderLoading.value = true;
    try {
      var response = await ApiImplementor.getOrderPlaceApiImplementer(userList: homeScreenController.commonClientJsonDataList,orderList: placeOderList.map((e) => e.toJson()).toList());
      if (response.results.isNotEmpty) {
        if(!isBasketOrder){
          Get.back();
        }
      }
    } catch (e) {
      print("${e}");
    } finally {
      isPlaceOrderLoading.value = false;
    }
  }
}