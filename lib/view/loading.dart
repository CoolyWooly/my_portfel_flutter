import 'package:flutter/material.dart';
import 'package:flutter_app/AppColors.dart';

class Loading extends StatelessWidget {
  final String loadingMessage;

  const Loading({Key key, this.loadingMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.COLOR_448DC1),
      ),
    );
  }
}