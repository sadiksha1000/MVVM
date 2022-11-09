import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/models/movies_model.dart';
import 'package:mvvm/repository/movie_repository.dart';

class MovieViewModel with ChangeNotifier {
  final _myRepo = MovieRepository();
  ApiResponse<MovieListModel> moviesList = ApiResponse.loading();

  setMoviesList(ApiResponse<MovieListModel> response) {
    moviesList = response;
    notifyListeners();
  }

  Future<void> fetchMoviesListAPI() async {
    setMoviesList(ApiResponse.loading());
    _myRepo.fetchMovies().then((value) {
      setMoviesList(ApiResponse.completed(value));
    }).onError((error, stackTrace) {
      setMoviesList(ApiResponse.error(error.toString()));
    });
  }
}
