import 'package:flutter/material.dart';
import 'package:flutter_app/AppColors.dart';
import 'package:flutter_app/blocs/movie_detail_bloc.dart';
import 'package:flutter_app/models/movie_response.dart';
import 'package:flutter_app/networking/api_response.dart';
import 'package:flutter_app/view/error.dart';
import 'package:flutter_app/view/loading.dart';

class ProjectDetail extends StatefulWidget {
  final int selectedMovie;

  const ProjectDetail(this.selectedMovie);

  @override
  _ProjectDetailState createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  MovieDetailBloc _movieDetailBloc;

  @override
  void initState() {
    super.initState();
    _movieDetailBloc = MovieDetailBloc(widget.selectedMovie);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          '',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<ApiResponse<Movie>>(
        stream: _movieDetailBloc.movieDetailStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            switch (snapshot.data.status) {
              case Status.LOADING:
                return Loading(loadingMessage: snapshot.data.message);
                break;
              case Status.COMPLETED:
                return ShowProjectDetail(displayMovie: snapshot.data.data);
                break;
              case Status.ERROR:
                return Error(
                  errorMessage: snapshot.data.message,
                  onRetryPressed: () =>
                      _movieDetailBloc.fetchMovieDetail(widget.selectedMovie),
                );
                break;
            }
          }
          return Container();
        },
      ),
    );
  }

  @override
  void dispose() {
    _movieDetailBloc.dispose();
    super.dispose();
  }
}

class ShowProjectDetail extends StatelessWidget {
  final Movie displayMovie;

  ShowProjectDetail({Key key, this.displayMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new SingleChildScrollView(
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Image.network(
              'https://image.tmdb.org/t/p/w342${displayMovie.posterPath}',
              fit: BoxFit.cover,
            ),
            height: 200,
            width: double.infinity,
          ),
          new Container(
            padding: EdgeInsets.all(16),
            color: AppColors.COLOR_2C70A1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayMovie.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "100.000.000 тг",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                ),
              ],
            ),
            width: double.infinity,
          ),
          new Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Описание",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  displayMovie.overview,
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            width: double.infinity,
          ),
          new Container(
            padding: EdgeInsets.all(16),
            color: AppColors.COLOR_F6F6F6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Стадия проекта",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Работающий бизнес",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            width: double.infinity,
          ),
          new SizedBox(
            height: 4,
          ),
          new Container(
            padding: EdgeInsets.all(16),
            color: AppColors.COLOR_F6F6F6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Отрасль",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "IT компания",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
            width: double.infinity,
          ),
          new Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.location_pin),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Казахстан",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                    Text(
                      "Алматы",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "images/map_shadow.png",
                      width: 150,
                      height: 105,
                    ),
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    )
                  ],
                )
              ],
            ),
            width: double.infinity,
          ),
          new Container(
            padding: EdgeInsets.all(8),
            color: AppColors.COLOR_124A72,
            child: Row(
              children: [
                Text(
                  "ID: 112233",
                  style: TextStyle(color: AppColors.COLOR_C5C5C5, fontSize: 10),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Text(
                  "Просмотры: 123",
                  style: TextStyle(color: AppColors.COLOR_C5C5C5, fontSize: 10),
                ),
              ],
            ),
            width: double.infinity,
          ),
          new Container(
            padding: EdgeInsets.all(16),
            color: AppColors.COLOR_124A72,
            child: Row(
              children: [
                Expanded(
                    child: ButtonTheme(
                  height: 50,
                  child: OutlineButton(
                    onPressed: () {},
                    borderSide: BorderSide(width: 1.0, color: Colors.white),
                    color: Colors.white,
                    // highlightedBorderColor: Colors.white,
                    // splashColor: Colors.white10,
                    //highlightColor: Colors.red,
                    child: Text(
                      "Презентация PDF",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                )),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                    child: ButtonTheme(
                  height: 50,
                  child: MaterialButton(
                    onPressed: () {
                      displayBottomSheet(context, displayMovie);
                    },
                    padding: EdgeInsets.symmetric(vertical: 8),
                    colorBrightness: Brightness.dark,
                    color: AppColors.COLOR_6EB9F0,
                    // elevation: 3.0,
                    // splashColor: Colors.green,
                    //highlightColor: Colors.red,
                    highlightElevation: 1.0,
                    child: Text(
                      "Контакты",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                  ),
                )),
              ],
            ),
            width: double.infinity,
          ),
        ],
      ),
    ));
  }
}

void displayBottomSheet(BuildContext context, Movie displayMovie) {
  showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.orange,
      builder: (BuildContext context) {
        return Column(
          children: [
            Text(
              "Контакты",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "8 747 564 37 97",
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ],
        );
      });
}
