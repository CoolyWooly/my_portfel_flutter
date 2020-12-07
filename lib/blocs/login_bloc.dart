import 'dart:async';

import 'package:flutter_app/networking/api_response.dart';
import 'package:flutter_app/repository/login_repository.dart';
import 'package:flutter_session/flutter_session.dart';

class LoginBloc {
  LoginRepository _loginRepository;

  StreamController _loginController;

  StreamSink<ApiResponse<String>> get loginSink =>
      _loginController.sink;

  Stream<ApiResponse<String>> get loginStream =>
      _loginController.stream;

  LoginBloc() {
    _loginController = StreamController<ApiResponse<String>>();
    _loginRepository = LoginRepository();
  }

  postLogin(String email, String password) async {
    loginSink.add(ApiResponse.loading('Login'));
    try {
      String token = await _loginRepository.postLogin(email, password);
      loginSink.add(ApiResponse.completed(token));
      var session = FlutterSession();
      await session.set("token", token);
      await session.set("name", "Yerlan");
      await session.set("id", 1);
    } catch (e) {
      loginSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _loginController?.close();
  }
}
