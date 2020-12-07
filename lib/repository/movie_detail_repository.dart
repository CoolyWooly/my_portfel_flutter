import 'package:flutter_app/networking/api_base_helper.dart';
import 'package:flutter_app/models/movie_response.dart';

class MovieDetailRepository {
  final String _apiKey = "080cd2b33055d3a70a8958dea29b9a11";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<Movie> fetchMovieDetail(int selectedMovie) async {
    final response = await _helper.get("movie/$selectedMovie?api_key=$_apiKey");
    return Movie.fromJson(response);
  }
}
