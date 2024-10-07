class PokemonEvolution {
  final int id;
  final String name;

  PokemonEvolution({required this.id, required this.name});
}

class Pokemon {
  final int id;
  final String name;
  final String imgUrl;
  final List<String> types;
  final double height;
  final double weight;
  final List<PokemonEvolution>? nextEvolutions;
  final List<PokemonEvolution>? previousEvolutions;

  Pokemon(
      {required this.id,
      required this.name,
      required this.imgUrl,
      required this.types,
      required this.height,
      required this.weight,
      this.nextEvolutions,
      this.previousEvolutions});

  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
      id: json['id'],
      name: json['name'],
      imgUrl: json['img'],
      types: List<String>.from(json['type']),
      height: double.parse((json['height'] as String).split(' ').first),
      weight: double.parse((json['weight'] as String).split(' ').first),
      previousEvolutions: json['previous_evolution'] != null
          ? (json['previous_evolution'] as List<dynamic>)
              .map(
                (previousEvolution) => PokemonEvolution(
                  id: int.parse(previousEvolution['num']),
                  name: previousEvolution['name'],
                ),
              )
              .toList()
          : null,
      nextEvolutions: json['next_evolution'] != null
          ? (json['next_evolution'] as List<dynamic>)
              .map(
                (nextEvolution) => PokemonEvolution(
                  id: int.parse(nextEvolution['num']),
                  name: nextEvolution['name'],
                ),
              )
              .toList()
          : null,
    );
  }

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, imgUrl: $imgUrl, types: $types, height: $height, weight: $weight, previousEvolutions: $previousEvolutions, nextEvolutions: $nextEvolutions)';
  }
}
