import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_servcies.dart';
import 'package:mvvm/resources/app_url.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostAPIResponse(AppUrl.loginUrl, data);
      print("response$response");
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> registerApi(dynamic data) async {
    try {
      dynamic response =
          await _apiServices.getPostAPIResponse(AppUrl.registerUrl, data);
      return response;
    } catch (e) {
      throw e;
    }
  }
}
