import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pokedex_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
          child: ElevatedButton(
        onPressed: () async {
          var pokemons = await ApiService.fetchPokemonData();
          _logger.d(pokemons);
        },
        child: Text("Press to fetch Pokemons"),
      )),
    );
  }
}
