import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pokedex_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Logger _logger = GetIt.instance<Logger>();
  final ApiService _apiService = GetIt.instance<ApiService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          var pokemons = await _apiService.fetchPokemonData();
          _logger.d(pokemons);
        },
        child: const Text("Press to fetch Pokemons"),
      )),
    );
  }
}
