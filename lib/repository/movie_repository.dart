import 'package:flutter_app/networking/api_base_helper.dart';
import 'package:flutter_app/models/movie_response.dart';

class MovieRepository {
  final String _apiKey = "080cd2b33055d3a70a8958dea29b9a11";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<Movie>> fetchMovieList() async {
    final response = await _helper.get("movie/popular?api_key=$_apiKey");
    return MovieResponse.fromJson(response).results;
  }
}
