import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_app/Api/ApiRequest.dart';
import 'package:flutter_app/model/MoviesModel.dart';
import 'package:flutter_app/widget/RowCard.dart';

import 'package:flutter_app/Api/Constanta.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<MoviesModel> listTopMovies = List();
  List<MoviesModel> listPopularMovies = List();
  String _errorMessage;

  void setPopularMovies() {
    List<MoviesModel> itemsMovies = List();
    ApiRequest.fetchMovies("movie/popular/").then((i) {
      try {
        i.forEach((movies) {
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
        listPopularMovies = itemsMovies;
      });
    });
  }

  void setTopRateMovies() {
    List<MoviesModel> itemsMovies = List();
    ApiRequest.fetchMovies("movie/top_rated/").then((i) {
      try {
        i.forEach((movies) {
          itemsMovies.add(new MoviesModel(
              title: movies.title,
              overView: movies.overView,
              voteAverage: movies.voteAverage,
              posterPath: movies.posterPath,
              date: movies.date,
              backDropPath: movies.backDropPath,
              id: movies.id));
        });
      } catch (ex) {
        _errorMessage = "Load Data Failed";
      }
      setState(() {
        listTopMovies = itemsMovies;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setTopRateMovies();
    setPopularMovies();
  }

  List<Widget> setRowsTop() {
    List<Widget> itemsRows = List();
    listTopMovies.forEach((movies) {
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

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return listTopMovies.length > 0 && listPopularMovies.length > 0
        ? new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin:
                    EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
                child: new Text(
                  "Popular",
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: height / 45,
                      fontWeight: FontWeight.w500),
                ),
              ),
              new Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: CarouselSlider(
                      height: height / 3.2,
                      viewportFraction: 1.0,
                      autoPlay: true,
                      items: listPopularMovies.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: new BoxDecoration(
                                  image: new DecorationImage(
                                      image: NetworkImage(
                                          Constanta.BASE_URL_IMG +
                                              i.backDropPath),
                                      fit: BoxFit.cover)),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    padding: new EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 2),
                                    decoration: new BoxDecoration(
                                        borderRadius: new BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        border: new Border.all(
                                            color: Colors.white)),
                                    child: new Text(
                                      "${i.voteAverage} IMDb",
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList())),
              new Container(
                margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                width: width,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(
                      "Top Movies",
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: height / 45,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: new Container(
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      width: width,
                      child: new ListView(
                        children: setRowsTop(),
                      )))
            ],
          )
        : _errorMessage == null
            ? new Container(
                child: new Center(
                    child: new CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(Colors.indigo),
                )),
              )
            : new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Failed Load Data"),
                    new FlatButton.icon(onPressed: (){
                      setPopularMovies();
                      setTopRateMovies();
                      setState(() {
                        _errorMessage = null;
                      });
                    }, icon: Icon(Icons.refresh), label: new Text(""))
                  ],
                ),
              );
  }
}
