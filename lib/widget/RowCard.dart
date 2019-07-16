import 'package:flutter/material.dart';
import 'package:flutter_app/pages/DetailMovies.dart';
import 'package:cached_network_image/cached_network_image.dart';

class RowCard extends StatelessWidget {
  final String voteAverage, title, posterPath, date, backDropPath, overView;
  final int id;

  RowCard(
      {this.id,
      this.title,
      this.voteAverage,
      this.posterPath,
      this.date,
      this.backDropPath,
      this.overView});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        var route = new MaterialPageRoute(builder: (BuildContext context) {
          return new DetailMovies(
            title: title,
            date: date,
            backDropPath: backDropPath,
            posterPath: posterPath,
            id: id,
            voteAverage: voteAverage,
            overView: overView,
          );
        });
        Navigator.of(context).push(route);
      },
      child: new Container(
        width: width,
        height: height / 5.5,
        child: Card(
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                width: width / 1.6,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new ListTile(
                      title: new Text(
                        title,
                        style: TextStyle(fontSize: height / 50),
                      ),
                      subtitle: new Text(date,
                          style: TextStyle(fontSize: height / 60)),
                    ),
                    new Container(
                      padding: EdgeInsets.all(5.0),
                      margin: EdgeInsets.only(left: 15),
                      decoration: new BoxDecoration(
                          color: Colors.indigo,
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(5.0))),
                      child: new Text(
                        "$voteAverage IMDB",
                        style: new TextStyle(
                            color: Colors.white, fontSize: height / 70),
                      ),
                    )
                  ],
                ),
              ),
              new CachedNetworkImage(
                imageUrl: posterPath,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
