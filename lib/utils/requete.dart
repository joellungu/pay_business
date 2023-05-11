import 'package:get/get.dart';

class Requete extends GetConnect {
  //String url = "http://192.168.0.100:8080/";
  //static String urlSt = "http://192.168.0.100:8080/";
  //String url = "http://10.0.2.2:8080/";
  //static String urlSt = "http://10.0.2.2:8080/";
  String url =
      "https://app-f637dc94-c48d-46d1-8cb0-ae5f64e1d871.cleverapps.io/";
  static String urlSt =
      "https://app-f637dc94-c48d-46d1-8cb0-ae5f64e1d871.cleverapps.io/";
  //
  Future<Response> getE(
    String path,
  ) async {
    return get("$url$path");
  }

  //
  Future<Response> postE(String path, var object) async {
    print("$url$path");
    return post("$url$path", object);
  }

  //
  Future<Response> putE(String path, var object) async {
    return put("$url$path", object);
  }

  //
  Future<Response> deleteE(String path) async {
    return delete("$url$path");
  }
}
