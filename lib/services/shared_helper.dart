import 'package:package_info_plus/package_info_plus.dart';

class SharedHelper {
  Future<String> getAppVersionString() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      return 'V $version ($buildNumber)';
    } catch (e) {
      return '';
    }
  }

  void logout() async {
    // clearSharedPref();
    // toast(language.lblLoggedOutSuccessfully);
  }
}
