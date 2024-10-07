import 'package:flutter/cupertino.dart';
import 'package:pokedex_app/core/injection.dart';
import 'package:pokedex_app/pokedex_app.dart';

void main() {
  configureDependencies();
  runApp(
    const PokedexApp(),
  );
}
