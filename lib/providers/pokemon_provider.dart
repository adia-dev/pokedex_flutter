import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/services/api_service.dart';

@injectable
class PokemonProvider with ChangeNotifier {
  final ApiService _apiService;
  final Logger _logger;

  PokemonProvider(this._apiService, this._logger);

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
    if (_searchQuery.isEmpty && _typeFilters.isEmpty) {
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

  void clearTypeFilters() {
    _typeFilters.clear();
    filterPokemons();
    notifyListeners();
  }

  void toggleTypeFilter(String type) {
    if (type == 'All') {
      clearTypeFilters();
      return;
    }

    if (_typeFilters.contains(type)) {
      removeTypeFilter(type);
    } else {
      addTypeFilter(type);
    }
  }
}
