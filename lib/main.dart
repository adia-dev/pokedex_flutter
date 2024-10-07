import 'package:flutter/cupertino.dart';
import 'package:pokedex_app/core/injection.dart';
import 'package:pokedex_app/pokedex_app.dart';
import 'package:provider/provider.dart';

void main() {
  configureDependencies();
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) {},
      child: const PokedexApp(),
    ),
  );
}
