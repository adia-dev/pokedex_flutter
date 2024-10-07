import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/services/api_service.dart';

@injectable
class PokemonProvider with ChangeNotifier {
  final Logger _logger = GetIt.instance<Logger>();
  final ApiService _apiService = GetIt.instance<ApiService>();

  // States
  List<Pokemon> _pokemons = [];
  List<Pokemon> _filteredPokemons = [];

  String _searchQuery = '';
  final Set<String> _typeFilters = {};
  String _errorMessage = '';
  bool _isLoading = false;

  // Getters
  List<Pokemon> get pokemons => _filteredPokemons;
  Set<String> get typeFilters => _typeFilters;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Methods
  Future<void> fetchPokemons() async {
    _isLoading = true;
    _errorMessage = '';

    try {
      _pokemons = await _apiService.fetchPokemonData();
      _filteredPokemons = _pokemons;
      _logger.i("Fetched ${_pokemons.length} pokemons !");
      filterPokemons();
    } catch (e, stackTrace) {
      _logger.e(
        "Error while fetching pokemons.",
        error: e,
        stackTrace: stackTrace,
      );

      _errorMessage = 'Failed to load pokemons';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void filterPokemons() {
    if (_searchQuery.isEmpty) {
      _filteredPokemons = _pokemons;
      return;
    }

    var lowerCaseSearchQuery = _searchQuery.toLowerCase();
    _filteredPokemons = _pokemons.where((p) {
      var matchingNames = p.name.toLowerCase().contains(lowerCaseSearchQuery);
      var matchingTypes = _typeFilters.isNotEmpty
          ? _typeFilters.intersection(p.types.toSet()).isNotEmpty
          : true;

      return matchingNames && matchingTypes;
    }).toList();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    filterPokemons();
    notifyListeners();
  }

  void addTypeFilter(String type) {
    if (!_typeFilters.add(type)) {
      return;
    }

    filterPokemons();
    notifyListeners();
  }

  void removeTypeFilter(String type) {
    if (!_typeFilters.remove(type)) {
      return;
    }

    filterPokemons();
    notifyListeners();
  }
}
