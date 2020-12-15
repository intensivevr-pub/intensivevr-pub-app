import 'package:intensivevr_pub/const.dart';

class ImageManager {
  static String getImageUrl(String localPath) {
    if (kUseHTTPS) {
      return "https://" + kServerUrl + "/static/" + localPath;
    } else {
      return "http://" + kServerUrl + "/static/" + localPath;
    }
  }

  static List<String> getImageUrlList(List<dynamic> localPaths) {
    List<String> paths = List<String>();
    for (String localPath in localPaths) {
      if (kUseHTTPS) {
        paths.add("https://" + kServerUrl + "/static/" + localPath);
      } else {
        paths.add("http://" + kServerUrl + "/static/" + localPath);
      }
    }
    return paths;
  }
}
