import 'dart:convert';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/controller/watch_list_controller.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/exchange_list_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/search_data_model.dart';
import 'package:ag_chirag_web/screens/module/Tabs/watch_list_tab/model/watch_list_model.dart';
import 'package:ag_chirag_web/utils/app_prefs_manager.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:motion_toast/motion_toast.dart';

class WatchListTabScreen extends StatefulWidget {
  const WatchListTabScreen({super.key});

  @override
  State<WatchListTabScreen> createState() => _WatchListTabScreenState();
}

class _WatchListTabScreenState extends State<WatchListTabScreen> {
  WatchListController watchListScreenController = Get.put(
    WatchListController(),
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Obx(
                        () => watchListScreenController.isLoadingNewSearch.value
                        ? const SizedBox(
                      height: 50,
                      child: Center(child: LinearProgressIndicator()),
                    )
                        : Container(color: Colors.white,
                      padding: EdgeInsetsGeometry.all(8),
                      height: 50,
                      child: DropdownSearch<SearchData>(
                        popupProps: const PopupProps.menu(showSearchBox: true),
                        items: watchListScreenController.newShareList,
                        dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            hintText: "Search",
                          ),
                        ),
                        itemAsString: (shareModel) => shareModel.symbol!,
                        onChanged: (val) async {
                          if (val != null) {
                            watchListScreenController.selectedShare = val;
                            watchListScreenController.selectedShareLotSizes.value = val.lotsize!;
                          }
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12), // Uniform spacing

                // 2. Exchange Type Dropdown (CORRECTED: Expanded is now a direct child of Row)
                Expanded(
                  flex: 1, // Increased slightly to 3 so "Type" text and arrow fit comfortably without clipping
                  child: Container(color: Colors.white,
                    height: 50,
                    padding: EdgeInsetsGeometry.all(8),
                    child: DropdownSearch<ExchangeListData>(
                      popupProps: const PopupProps.menu(),
                      items: watchListScreenController.exchangeList,
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          hintText: "Type",
                        ),
                      ),
                      itemAsString: (sharelistdata) => sharelistdata.exchangeName,
                      onChanged: (val) async {
                        // Added a null-safe check to prevent crashes if 'val' is null
                        if (val != null && val.shortName != "") {
                          await watchListScreenController.getSearchScriptApi(
                            type: val.shortName,
                          );
                        }
                      },
                    ),
                  ),
                ),

                const SizedBox(width: 12), // Uniform spacing

                // 3. Action Button
                Obx(() => actionBtn(
                    isLoading: watchListScreenController.isScriptLoading.value,
                    label: 'Load Data',
                    onTap: () {
                      watchListScreenController.getLoadSearchScriptApi();
                    },
                    primary: true,
                  ),
                ),

              ],
            ),
          ),
            SizedBox(height: 20,),
         Row(mainAxisAlignment: MainAxisAlignment.center,spacing: 20,
           children: [
           actionBtn(
             label: '+ Add watch list',
             onTap: () async {
               if(watchListScreenController.selectedShare != null){
                 List<WatchListModel> watchList =
                 watchListScreenController.watchlist
                     .where((element) {
                   return element.tradingsymbol ==
                       watchListScreenController.selectedShare!.symbol;
                 }).toList();

                 if (watchList.isNotEmpty) {
                   // Helper().showMessage(message: "Already added");
                 } else {
                   WatchListModel watchListModel = WatchListModel(
                       exchange: watchListScreenController
                           .selectedShare!.exchSeg,
                       symboltoken: watchListScreenController
                           .selectedShare!.token,
                       tradingsymbol: watchListScreenController
                           .selectedShare!.symbol,
                       ltp: 0,
                       lotsize: watchListScreenController
                           .selectedShareLotSizes.value
                           .toString());
                   watchListScreenController.addToWatchList(watchListModel);

                   List<WatchListModel> watchListLocal =
                   await SharedPref.getWatchListData();

                   watchListLocal.add(watchListModel);
                   List<String> userListForSp = [];

                   for (var item in watchListLocal) {
                     userListForSp.add(json.encode(item.toJson()));
                   }

                   SharedPref.setWatchData(userListForSp);
                 }
               }else{
                 // ConfigToast.showToast( message: "Please Select First", type: ToastType.error);
                 print("DD=> ${Get.overlayContext}");

                 MotionToast.error(
                   opacity: 0.8,
                   toastDuration: const Duration(milliseconds: 2000),
                   title: Text("Please Select First",style: TextStyle(color: Colors.white),),
                   description: Text("",style: TextStyle(color: Colors.white),),
                   toastAlignment: Alignment.topRight,
                   // animationType: animationType,
                 ).show(context);
               }
             },
             primary: true, isLoading: false,
           ),

           actionBtn(
             label: 'Price Refresh',
             onTap: () async {
               await watchListScreenController.getSharePriceApi();
               },
             primary: true, isLoading: false,
           ),

         ],),
          SizedBox(height: 20,),
          Obx(()=> watchListScreenController.watchlist.isNotEmpty ?
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(height: Get.height*0.70,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 240, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 2.10),
                itemCount: watchListScreenController.watchlist.length,
                itemBuilder: (ctx, i) {
                  final item = watchListScreenController.watchlist[i];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [BoxShadow(color: Color(0x06000000), blurRadius: 6)],
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(item.tradingsymbol.toString(), style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF111827))),
                        InkWell(onTap: (){
                          showDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  title: Text(
                                      "Remove ${watchListScreenController.watchlist[i].tradingsymbol} from Watch List?"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                      Navigator.pop(
                                          context);
                                    }, child: Text("No"),

                                    ),
                                    ElevatedButton(
                                   onPressed: () {
                                      watchListScreenController.removeFromWatchList(
                                          watchListScreenController.watchlist[i],
                                          i);
                                      Navigator.pop(
                                          context);
                                    }, child: Text("Yes"),
                                    ),
                                  ],
                                );
                              });
                        },
                            child: Icon(Icons.star, size: 24, color: const Color(0xFFD97706))),
                      ]),
                      Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                        Text(item.exchange.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827))),
                          const Spacer(),
                          Expanded(
                          child: Obx(()=>  watchListScreenController.watchListDataLoad.value? SizedBox(height: 4,
                              child: LinearProgressIndicator(color: Color(0xFF2563EB),)) : Text(item.ltp.toString(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF111827)))),
                        ),
                      ],)
                    ]),
                  );
                },
              ),
            ),
          ) : const Center(
            child: SizedBox(
              child: Text("Data Not Available"),
            ),
          ))
        ],
      ),
    );
  }

  Widget actionBtn({
    required String label,
    required VoidCallback onTap,
    required bool isLoading,
    bool primary = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: primary ? const Color(0xFF2563EB) : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: primary ? const Color(0xFF2563EB) : const Color(0xFFD1D5DB),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: primary ? Colors.white : const Color(0xFF374151),
                ),
              ),
      ),
    );
  }
}
