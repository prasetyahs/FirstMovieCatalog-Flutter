

class MoviesResponse {

  List<dynamic> results;
  int page;
  int totalResult;
  int totalPages;

  MoviesResponse({this.results,this.page,this.totalResult,this.totalPages});

  factory MoviesResponse.fromJson(Map<String,dynamic> parseMovie) {
    return new MoviesResponse(
      results:  parseMovie['results'],
      page:  parseMovie['page'],
      totalPages: parseMovie['total_pages'],
      totalResult:  parseMovie['total_results']
    );
  }
}
