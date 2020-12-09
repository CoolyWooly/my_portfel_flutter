import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AppColors.dart';
import 'package:flutter_app/blocs/login_bloc.dart';
import 'package:flutter_app/main_screen.dart';
import 'package:flutter_app/networking/api_response.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _loginBloc.dispose();
    super.dispose();
  }

  void navigationPage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => new MainScreen()));
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = LoginBloc();
    _loginBloc.loginStream.listen((event) {
      switch (event.status) {
        case Status.LOADING:
          break;
        case Status.COMPLETED:
          navigationPage();
          break;
        case Status.ERROR:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: AppColors.BACKGROUND,
        body: Stack(
          children: [
            Align(
                alignment: Alignment.bottomRight,
                child: SvgPicture.asset("images/people_login.svg")),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(26),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                        elevation: 5,
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 17),
                          child: Column(
                            children: [
                              Text(
                                "Войти в кабинет".toUpperCase(),
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 26),
                              new TextField(
                                // controller: searchController,
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  filled: true,
                                  fillColor: AppColors.COLOR_F8F8F8,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: AppColors.COLOR_E3E3E3),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: AppColors.COLOR_E3E3E3),
                                  ),
                                ),
                              ),
                              SizedBox(height: 22),
                              new TextField(
                                // controller: searchController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                enableSuggestions: false,
                                controller: _passwordController,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: 'Пароль',
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  filled: true,
                                  fillColor: AppColors.COLOR_F8F8F8,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: AppColors.COLOR_E3E3E3),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                    borderSide:
                                    BorderSide(color: AppColors.COLOR_E3E3E3),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 22,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 26),
                                child: ButtonTheme(
                                  height: 50,
                                  minWidth: double.infinity,
                                  child: RaisedButton(
                                      onPressed: () {
                                        _loginBloc.postLogin(
                                            _emailController.text,
                                            _passwordController
                                                .text); // navigationPage();
                                      },
                                      textColor: Colors.white,
                                      padding: const EdgeInsets.all(0.0),
                                      color: AppColors.COLOR_8CD6FF,
                                      child: Text(
                                        "Войти",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 18),
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)))),
                                ),
                              )
                            ],
                          ),
                        )),
                    SizedBox(
                      height: 26,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Забыли пароль?",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                        FlatButton(
                          textColor: Colors.black,
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            /*...*/
                          },
                          child: Text(
                            "Восстановить",
                            style: TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.normal,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
