import 'dart:convert';

import 'package:ag_chirag_web/Api/api_implementor.dart';
import 'package:ag_chirag_web/screens/module/Tabs/home_tab/model/client_json_data.dart';
import 'package:ag_chirag_web/screens/module/Tabs/home_tab/model/user_model.dart';
import 'package:ag_chirag_web/utils/app_prefs_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeTabController extends GetxController{
  final _col = FirebaseFirestore.instance.collection('clients');
  // List<UserModel> usersList = [];
  RxList<UserModel> usersList = <UserModel>[].obs;
  String error = "";

  List<ClientJsonDataModel> clientJsonDataList = [];
  List<ClientJsonDataModel> commonClientJsonDataList = [];
  RxBool isLoginApiLoading = false.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDataOnly();
  }

  Future<void> initializeData() async {
    isLoginApiLoading.value = true;

    await  userLoginApi();
    await  userAccountDetailApi();

    isLoginApiLoading.value = false;
  }

  void fetchDataOnly(){
    SharedPref.getUserData().then((value) {
      for (var item in value) {
        addUser(item);
      }
      update();
    });
  }

void addUser(UserModel user) {
  usersList.add(user);

    clientJsonDataList = usersList.map((e) {
      return ClientJsonDataModel(
        ipName: e.ipName,
        ipPwd: e.ipPwd,
        port: e.port,
        clientcode: e.clientcode,
        password: e.password,
        totpSecret: e.secretKey,
        publicIP: e.publicIP,
        apiKey: e.privateKey,
      );
    }).toList();
  }


  Future<void> fetchUsers() async {
    loading.value = true;
    error = "";
    try {
      final snap = await _col.orderBy('username').get();
      usersList.value = snap.docs.map(UserModel.fromFirestore).toList();
      List<String> userListForSp = [];
      for (var item in usersList) {
        userListForSp.add(json.encode(item.toJson()));
      }
      SharedPref.setUserData(userListForSp);

      clientJsonDataList = usersList.map((e) {
        return ClientJsonDataModel(
          ipName: e.ipName,
          ipPwd: e.ipPwd,
          port: e.port,
          clientcode: e.clientcode,
          password: e.password,
          totpSecret: e.secretKey,
          publicIP: e.publicIP,
          apiKey: e.privateKey,
        );
      }).toList();

      loading.value = false;
    } catch (e) {
      error = e.toString();
      loading.value = false;
    }
  }

  void deleteUser(UserModel userModel,int index) async {
    ///Delete user from list and Sp also

    List<UserModel> userListLocal = await SharedPref.getUserData();

    for (int i = 0; i < usersList.length; i++) {
      if (userListLocal[i].privateKey == userModel.privateKey && userListLocal[i].clientcode == userModel.clientcode && userListLocal[i].password == userModel.password) {
        userListLocal.removeAt(i);
        usersList.removeAt(index);
        clientJsonDataList.removeAt(index);
      }
    }

    List<String> userListForSp = [];

    for (var item in userListLocal) {
      userListForSp.add(json.encode(item.toJson()));
    }

    SharedPref.setUserData(userListForSp);
    update();
  }



  Future<void> userLoginApi() async {
    isLoginApiLoading.value = true;
    try {

      var response = await ApiImplementor.userLoginApiImplementer(userList: clientJsonDataList);
      if (response.results.isNotEmpty) {
        for(int i=0; i<response.results.length;i++){
          if(response.results[i].jwt.isNotEmpty){
            usersList[i].jwtToken = response.results[i].jwt;
          }
        }
        commonClientJsonDataList = usersList
            .where((e) => e.jwtToken.isNotEmpty)
            .map((e) {
          return ClientJsonDataModel(
              ipName: e.ipName,
              ipPwd: e.ipPwd,
              port: e.port,
              clientcode: e.clientcode,
              password: e.password,
              totpSecret: e.secretKey,
              publicIP: e.publicIP,
              apiKey: e.privateKey,
              jwtToken: e.jwtToken
          );
        }).toList();
        usersList.refresh();
      }
    } catch (e) {
      print("${e}");
    } finally {
      isLoginApiLoading.value = false;

    }
  }

  Future<void> userAccountDetailApi() async {
    isLoginApiLoading.value = true;
    try {

      var response = await ApiImplementor.userAccountDetailApiImplementer(userList: commonClientJsonDataList);
      if (response.results.isNotEmpty) {
        for(int i=0; i<response.results.length;i++){
          int pos = usersList.indexWhere((element) => element.clientcode == response.results[i].client);
          usersList[pos].currentBalance = response.results[i].data!.availablecash;
        }
        usersList.refresh();
      }
    } catch (e) {
      print("${e}");
    } finally {
      isLoginApiLoading.value = false;

    }
  }

}