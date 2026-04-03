import 'package:ag_chirag_web/screens/module/user/screen/user_list_screen.dart';
import 'package:get/get.dart';

class UserDetailController extends GetxController {
  RxList<UserData> userList = <UserData>[].obs;

  @override
  void onInit() {
    super.onInit();
    userList.value = _generateMockData();
  }

  List<UserData> _generateMockData() {
    return [
      UserData(
        name: 'bhavesh jain',
        email: "bhaveshjain@gmail.com",
        phone: "9729662662",
        registerDate: "29/09/2025",
        orderCount: 0,
      ),
      UserData(
        name: 'rohit vaghela',
        email: "rohit@gmail.com",
        phone: "2255665523",
        registerDate: "25/09/2025",
        orderCount: 1,
      ),
      UserData(
        name: 'bhavesh jain',
        email: "bhaveshjain@gmail.com",
        phone: "9729662662",
        registerDate: "29/09/2025",
        orderCount: 2,
      ),
      UserData(
        name: 'rohit vaghela',
        email: "rohit@gmail.com",
        phone: "2255665523",
        registerDate: "25/09/2025",
        orderCount: 0,
      ),
      UserData(
        name: 'bhavesh jain',
        email: "bhaveshjain@gmail.com",
        phone: "9729662662",
        registerDate: "29/09/2025",
        orderCount: 4,
      ),
      UserData(
        name: 'rohit vaghela',
        email: "rohit@gmail.com",
        phone: "2255665523",
        registerDate: "25/09/2025",
        orderCount: 0,
      ),
      UserData(
        name: 'bhavesh jain',
        email: "bhaveshjain@gmail.com",
        phone: "9729662662",
        registerDate: "29/09/2025",
        orderCount: 8,
      ),
      UserData(
        name: 'rohit vaghela',
        email: "rohit@gmail.com",
        phone: "2255665523",
        registerDate: "25/09/2025",
        orderCount: 0,
      ),



    ];
  }
}