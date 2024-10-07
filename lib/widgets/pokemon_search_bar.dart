import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokedex_app/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonSearchBar extends StatefulWidget {
  const PokemonSearchBar({super.key});

  @override
  State<PokemonSearchBar> createState() => _PokemonSearchBarState();
}

class _PokemonSearchBarState extends State<PokemonSearchBar> {
  Timer? _debounceTimer;
  static const int _debounceDelayInMs = 350;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonProvider>(
        builder: (BuildContext context, provider, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          onChanged: (String value) {
            _debounceTimer?.cancel();

            _debounceTimer = Timer(
              const Duration(milliseconds: _debounceDelayInMs),
              () {
                provider.updateSearchQuery(value);
              },
            );
          },
          decoration: InputDecoration(
            hintText: 'Search Pokémon',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
          ),
        ),
      );
    });
  }
}
