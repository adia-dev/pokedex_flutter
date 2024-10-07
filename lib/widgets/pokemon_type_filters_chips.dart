import 'package:flutter/material.dart';
import 'package:pokedex_app/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class PokemonTypeFiltersChips extends StatelessWidget {
  const PokemonTypeFiltersChips({super.key});

  static const _types = ['All', 'Grass', 'Fire', 'Water', 'Bug', 'Normal'];

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: _types.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final type = _types[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(type),
                  selected: type == 'All' && provider.typeFilters.isEmpty ||
                      provider.typeFilters.contains(type),
                  onSelected: (selected) {
                    provider.toggleTypeFilter(type);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
