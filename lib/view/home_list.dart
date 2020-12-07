import 'package:flutter/material.dart';
import 'package:flutter_app/AppColors.dart';
import 'package:flutter_app/blocs/movie_bloc.dart';
import 'package:flutter_app/models/movie_response.dart';
import 'package:flutter_app/networking/api_response.dart';
import 'package:flutter_app/view/error.dart';
import 'package:flutter_app/view/loading.dart';
import 'package:flutter_app/view/project_detail.dart';

class HomeList extends StatefulWidget {
  @override
  _HomeListState createState() => new _HomeListState();
}

class _HomeListState extends State<HomeList> {
  MovieBloc _bloc;
  final TextEditingController searchController = new TextEditingController();
  String filter;

  @override
  void initState() {
    super.initState();
    _bloc = MovieBloc();
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Container(
          color: AppColors.COLOR_6EB9F0,
          child: new Padding(
            padding: new EdgeInsets.all(8.0),
            child: new TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Что ищете?',
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0)),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: new RefreshIndicator(
            onRefresh: () => _bloc.fetchMovieList(),
            child: StreamBuilder<ApiResponse<List<Movie>>>(
              stream: _bloc.movieListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data.status) {
                    case Status.LOADING:
                      return Loading(loadingMessage: snapshot.data.message);
                      break;
                    case Status.COMPLETED:
                      return ProjectList(projectList: snapshot.data.data);
                      break;
                    case Status.ERROR:
                      return Error(
                        errorMessage: snapshot.data.message,
                        onRetryPressed: () => _bloc.fetchMovieList(),
                      );
                      break;
                  }
                }
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class ProjectList extends StatelessWidget {
  final List<Movie> projectList;

  const ProjectList({Key key, this.projectList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: projectList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        // childAspectRatio: 1.5 / 1.8,
        childAspectRatio: 0.8,
      ),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: AppColors.COLOR_448DC1,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProjectDetail(projectList[index].id)));
                  },
                  child: new Stack(
                    children: [
                      new Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w342${projectList[index].posterPath}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              projectList[index].overview,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 8, right: 8, bottom: 8),
                            child: Text(
                              "10.000.000 тг",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      new Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            ),
                          )),
                    ],
                  ))),
        );
      },
    );
  }
}
