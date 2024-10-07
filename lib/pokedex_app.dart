import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pokedex_app/providers/pokemon_provider.dart';
import 'package:pokedex_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PokemonProvider>(
          create: (_) => GetIt.instance<PokemonProvider>(),
        )
      ],
      child: const MaterialApp(
        title: 'Pokédex',
        home: HomeScreen(),
      ),
    );
  }
}
