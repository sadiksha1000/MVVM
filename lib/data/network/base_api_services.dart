abstract class BaseApiServices {
  Future<dynamic> getResponse(String url);

  Future<dynamic> getPostAPIResponse(String url, dynamic data);
}
