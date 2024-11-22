import 'package:flutter/material.dart';
import 'package:pokemon/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:pokemon/provider/pokemon_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // Ensures bindings are initialized
  await Firebase.initializeApp();  // Initialize Firebase before running the app
  runApp(
    ChangeNotifierProvider(
      create: (context) => PokemonProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
