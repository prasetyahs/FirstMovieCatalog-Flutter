import 'package:flutter/material.dart';
import 'package:flutter_app/Api/ApiRequest.dart';
import 'package:flutter_app/Api/Constanta.dart';

class DetailMovies extends StatefulWidget {
  final String voteAverage, title, posterPath, date, backDropPath, overView;
  final int id;

  DetailMovies(
      {Key key,
      this.id,
      this.title,
      this.posterPath,
      this.date,
      this.backDropPath,
      this.voteAverage,
      this.overView})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new DetailMoviesState();
  }
}

class DetailMoviesState extends State<DetailMovies> {
  List<Widget> listCast = [];
  String genres;

  void listGenres() {
    ApiRequest.fetchGenres(widget.id).then((list) {
      setState(() {
        genres = list.toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    listGenres();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new Scaffold(
      body: new Container(
        width: width,
        height: height,
        child: new NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBox) {
              return <Widget>[
                SliverAppBar(
                  leading: new InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: new Icon(Icons.arrow_back_ios),
                  ),
                  expandedHeight: width / 1.1,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.indigo,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      title: new Text("Detail Movie"),
                      background: Image.network(
                        "${Constanta.BASE_URL_IMG + widget.backDropPath}",
                        fit: BoxFit.cover,
                      )),
                ),
              ];
            },
            body: new Container(
              width: width,
              height: height,
              margin: EdgeInsets.only(left: 15, right: 15, top: 15),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Row(
                    children: <Widget>[
                      Container(
                        width: width / 1.5,
                        child: new Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: width / 15),
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        padding: new EdgeInsets.symmetric(
                            horizontal: 5, vertical: 2),
                        decoration: new BoxDecoration(
                            borderRadius: new BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            border: new Border.all(color: Colors.indigo)),
                        child: new Text(
                          "IMDb",
                          style: new TextStyle(color: Colors.indigo),
                        ),
                      ),
                      new Text(widget.voteAverage,
                          style: new TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  new SizedBox(height: 15),
                  new Text(
                    genres != null
                        ? genres.replaceAll("]", "").replaceAll("[", "")
                        : "",
                    style: new TextStyle(color: Colors.grey),
                  ),
                  new SizedBox(height: 15),
                  new Text(
                    widget.date,
                    style: new TextStyle(color: Colors.grey),
                  ),
                  new Container(
                      margin: new EdgeInsets.symmetric(vertical: 35),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            "Story",
                            style: new TextStyle(
                                fontSize: width / 25,
                                fontWeight: FontWeight.bold),
                          ),
                          new SizedBox(
                            height: 15,
                          ),
                          new Text(
                            widget.overView,
                            style: new TextStyle(fontSize: width / 30),
                            textAlign: TextAlign.justify,
                          ),
                        ],
                      )),
                ],
              ),
            )),
      ),
    );
  }
}
