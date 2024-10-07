import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:logger/web.dart';
import 'package:pokedex_app/models/pokemon.dart';

@LazySingleton()
class ApiService {
  static String get apiEndpoint =>
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  final Logger _logger;

  ApiService(this._logger);

  Future<List<Pokemon>> fetchPokemonData() async {
    try {
      var url = Uri.parse(apiEndpoint);
      var response = await http.get(url);

      if (response.statusCode != 200) {
        _logger.w(
            "Failed to fetch pokemon data, received status code: ${response.statusCode}");
        throw Exception('Failed to fetch pokemon data');
      }

      _logger.i("Successfully fetched pokemons !");

      final dynamic jsonResponse = jsonDecode(response.body);
      final List<dynamic> pokemonJsonList = jsonResponse['pokemon'];

      return pokemonJsonList.map((json) {
        return Pokemon.fromJson(json as Map<String, dynamic>);
      }).toList();
    } catch (e, stackTrace) {
      _logger.e(
        "An error occurred while trying to fetch pokemon data",
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }
}
