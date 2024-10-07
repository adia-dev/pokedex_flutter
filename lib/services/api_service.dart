import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:pokedex_app/models/pokemon.dart';

class ApiService {
  static String get apiEndpoint =>
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  static final Logger _logger = Logger();

  static Future<List<Pokemon>> fetchPokemonData() async {
    var logger = Logger();

    try {
      var url = Uri.parse(apiEndpoint);
      var response = await http.get(url);

      if (response.statusCode != 200) {
        logger.w(
            "Failed to fetch pokemon data, received status code: ${response.statusCode}");
        throw Exception('Failed to fetch pokemon data');
      }

      final dynamic jsonResponse = jsonDecode(response.body);
      final List<dynamic> pokemonJsonList = jsonResponse['pokemon'];

      _logger.d(pokemonJsonList[0]);

      return pokemonJsonList.map((json) {
        return Pokemon.fromJson(json as Map<String, dynamic>);
      }).toList();
    } catch (e, stackTrace) {
      logger.e(
        "An error occurred while trying to fetch pokemon data",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
