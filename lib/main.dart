import 'package:flutter/material.dart';

import 'src/pages/pokedex/pokedex_pages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PokedexPage());
  }
}
