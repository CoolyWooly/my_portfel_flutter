import 'package:flutter_app/networking/api_base_helper.dart';
import 'package:flutter_app/models/movie_response.dart';

class LoginRepository {
  final String _apiKey = "080cd2b33055d3a70a8958dea29b9a11";

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<String> postLogin(String email, String password) async {
    final response = await _helper.post("movie/popular?api_key=$_apiKey", null);
    await Future.delayed(Duration(seconds: 2));
    return email + password;
  }


}
