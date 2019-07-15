import 'package:flutter/material.dart';
import 'package:flutter_app/Api/ApiRequest.dart';
import 'package:flutter_app/Api/Constanta.dart';
import 'package:flutter_app/model/MoviesModel.dart';
import 'package:flutter_app/widget/RowCard.dart';

class MoviesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MoviesPageState();
  }
}

class MoviesPageState extends State<MoviesPage> with AutomaticKeepAliveClientMixin {
  List<MoviesModel> listMovies = List();
  String _errorMessage;

  List<Widget> setRowsList() {
    List<Widget> itemsRows = List();
    listMovies.forEach((movies) {
      itemsRows.add(new RowCard(
        title: movies.title,
        date: movies.date,
        posterPath: Constanta.BASE_URL_IMG + movies.posterPath,
        voteAverage: movies.voteAverage,
        id: movies.id,
        overView: movies.overView,
        backDropPath: movies.backDropPath,
      ));
    });
    return itemsRows;
  }

  void setListMovies() {
    List<MoviesModel> itemsMovies = List();
    ApiRequest.fetchMovies("discover/movie/").then((moviesList) {
      try {
        moviesList.forEach((movies) {
          itemsMovies.add(new MoviesModel(
              overView: movies.overView,
              title: movies.title,
              id: movies.id,
              posterPath: movies.posterPath,
              date: movies.date,
              voteAverage: movies.voteAverage,
              backDropPath: movies.backDropPath));
        });
      } catch (NoSuchMethodError) {
        setState(() {
          _errorMessage = "Load Data Failed";
        });
      }
      setState(() {
        listMovies = itemsMovies;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setListMovies();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: listMovies.length > 0
          ? new ListView(
              children: setRowsList(),
            )
          : _errorMessage == null
              ? new Center(
                  child: new CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigo),
                  ),
                )
              : new Center(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text("Failed Load Data"),
                      new FlatButton.icon(
                          onPressed: () {
                            setRowsList();
                            setState(() {
                              _errorMessage = null;
                            });
                          },
                          icon: Icon(Icons.refresh),
                          label: new Text(""))
                    ],
                  ),
                ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
