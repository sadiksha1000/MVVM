import 'package:mvvm/data/network/base_api_services.dart';
import 'package:mvvm/data/network/network_api_servcies.dart';
import 'package:mvvm/models/movies_model.dart';
import 'package:mvvm/resources/app_url.dart';

class MovieRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  Future<MovieListModel> fetchMovies() async {
    try {
      dynamic response =
          await _apiServices.getResponse(AppUrl.moviesListEndPoint);
      return response = MovieListModel.fromJson(response);
    } catch (e) {
      throw e;
    }
  }
}
