import 'dart:io';

class ApiUrls {
  static bool isApiLoggerEnabled = true;
  // static String domainName = "https://sumandeep.icrp.in"; //Live
  static String domainName = "http://localhost:3000/"; //local
  // static String domainName = "https://demoerp1.ngu.ac.in"; //local
  static String baseUrl = "$domainName/";
  static String feeBaseUrl = "$domainName/erp/Web_Services.asmx/";

  static String liveApplicationLink = Platform.isAndroid
      ? "https://play.google.com/store/apps/details?id=com.inifnityinfoway.sumamdeep"
      : Platform.isIOS
          ? "https://apps.apple.com/in/app/sumandeep-vidyapeeth/id6751535738"
          : "";



  //preferences keys
  static const String loginUser = 'LoginUser';
  static const String userName = 'UserName';
  static const String userType = 'UserType';
  static const String accessToken = 'accessToken';

}
