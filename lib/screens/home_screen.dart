import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/services/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Services
  final Logger _logger = GetIt.instance<Logger>();
  final ApiService _apiService = GetIt.instance<ApiService>();

  // States
  List<Pokemon> _pokemons = List.empty();
  List<Pokemon> _filteredPokemons = List.empty();
  TextEditingController _filterTextFieldController = TextEditingController();
  String _filter = "";

  @override
  void initState() {
    if (mounted) {
      _fetchPokemons();
    }

    super.initState();
  }

  @override
  void dispose() {
    _filterTextFieldController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                await _fetchPokemons();
              },
              child: const Text("Press to fetch Pokemons"),
            ),
          ),
          TextField(
            controller: _filterTextFieldController,
            onChanged: (String value) {
              _filter = value;
              _filterPokemons();
              setState(() {});
            },
          ),
          Expanded(
            child: GridView.builder(
              itemCount: _filteredPokemons.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _filteredPokemons[index].name,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Id: ${_filteredPokemons[index].id.toString()}",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Image.network(
                          _filteredPokemons[index].imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 8,
                childAspectRatio: 1,
              ),
            ),
          )
        ],
      ),
    );
  }

  // Private methods

  Future<void> _fetchPokemons() async {
    _pokemons = await _apiService.fetchPokemonData();
    _filteredPokemons = _pokemons;
    _logger.i("Fetched ${_pokemons.length} pokemons !");
    setState(() {});
  }

  void _filterPokemons() async {
    if (_filter.isEmpty) {
      _filteredPokemons = _pokemons;
      return;
    }

    _filteredPokemons = _pokemons
        .where((p) => p.name.toLowerCase().contains(_filter.toLowerCase()))
        .toList();
  }
}
