import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon.dart';

class PokemonCard extends StatelessWidget {
  final String id;
  final String name;
  final String imgUrl;
  final List<String> types;

  const PokemonCard({
    super.key,
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.types,
  });

  factory PokemonCard.fromPokemon(Pokemon pokemon) {
    return PokemonCard(
      id: pokemon.id.toString(),
      name: pokemon.name,
      types: pokemon.types,
      imgUrl: pokemon.imgUrl,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Expanded(
            child: Image.network(
              imgUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error);
              },
            ),
          ),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text('ID: $id'),
        ],
      ),
    );
  }
}
