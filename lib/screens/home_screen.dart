import 'package:flutter/material.dart';
import 'package:pokedex_app/widgets/pokemon_card.dart';
import 'package:pokedex_app/widgets/pokemon_search_bar.dart';
import 'package:pokedex_app/widgets/pokemon_type_filters_chips.dart';
import 'package:pokedex_app/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PokemonProvider>(context, listen: false).fetchPokemons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokédex'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Consumer<PokemonProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.errorMessage.isNotEmpty) {
            return Center(
                child: Text(
              provider.errorMessage,
              style: const TextStyle(
                color: Colors.red,
              ),
            ));
          } else {
            return Column(
              children: [
                const PokemonSearchBar(),
                const PokemonTypeFiltersChips(),
                Expanded(
                  child: provider.pokemons.isEmpty
                      ? const Center(child: Text('No Pokémons found.'))
                      : GridView.builder(
                          itemCount: provider.pokemons.length,
                          itemBuilder: (context, index) {
                            return PokemonCard.fromPokemon(
                                provider.pokemons[index]);
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 8,
                            childAspectRatio: 1,
                          ),
                        ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
