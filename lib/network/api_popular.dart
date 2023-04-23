import 'dart:convert';
import 'package:flutter_application_1/models/popular.dart';
import 'package:flutter_application_1/models/popular_cast.dart';
import 'package:flutter_application_1/models/popular_trailer.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiPopular {
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  Uri link = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=d347bb71853e5b73cc14f36ac111109f&language=es-MX&page=1');
  Future<List<Popular>?> getAllPopular() async {
    var result = await http.get(link);
    var listJson = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJson.map((popular) => Popular.fromMap(popular)).toList();
    }
    return null;
  }

  Future<List<PopularTrailer>?> getTrailer(int movieId) async {
    try {
      var result = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=d7236b730825fb7b3c7e23e7d91e473c&language=es-MX'));
      var listJson = jsonDecode(result.body)['results'] as List;
      if (result.statusCode == 200) {
        return listJson
            .map((popular) => PopularTrailer.fromMap(popular))
            .toList();
      }
    } catch (e) {
      logger.w('error en trailer');
      logger.i(e.toString());
      return null;
    }
    return null;
    /*
    Uri link = Uri.parse(
        'https://api.themoviedb.org/3/movie/$movie_id/videos?api_key=d347bb71853e5b73cc14f36ac111109f&language=es-MX');
    var result = await http.get(link);
    var listJson = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJson
          .map((popular) => PopularTrailer.fromMap(popular))
          .toList();
    }
    return null;
    */
  }

  Future<List<PopularCast>?> getCast(int movieId) async {
    /*
    var result = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/${movie_id}/credits?api_key=d347bb71853e5b73cc14f36ac111109f&language=es-MX'));
    var listJson = jsonDecode(result.body)['cast'] as List;
    if (result.statusCode == 200) {
      return listJson.map((popular) => PopularCast.fromMap(popular)).toList();
    }
    return null;
    */
    try {
      var result = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=d7236b730825fb7b3c7e23e7d91e473c&language=es-MX'));
      var listJson = jsonDecode(result.body)['cast'] as List;
      if (result.statusCode == 200) {
        return listJson.map((popular) => PopularCast.fromMap(popular)).toList();
      }
    } catch (e) {
      logger.w('error en cast');
      logger.i(e.toString());
      return null;
    }
    return null;
  }
}
