import 'package:flutter/material.dart';
import 'package:pokemon/model/pokemon_model.dart';
import 'package:pokemon/provider/pokemon_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _searchController = TextEditingController();
  String _selectedColor = 'All'; // Default color filter

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<PokemonProvider>(context, listen: false);
      provider.fetchPokemons(); // Fetch Pokémon data initially
    });

    _searchController.addListener(() {
      final provider = Provider.of<PokemonProvider>(context, listen: false);
      provider.filterPokemons(_searchController.text); // Filter Pokémon by name or ID
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PokemonProvider>(context);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 235, 241),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Pokédex',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Color.fromARGB(255, 11, 49, 62),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Search for a Pokémon by name or using its National Pokédex number.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Search bar
                Expanded(
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 245, 245, 246),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color.fromARGB(255, 218, 229, 230)),
                    ),
                    child: TextField(
                      controller: _searchController,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Name or Number',
                        hintStyle: const TextStyle(color: Color.fromARGB(255, 158, 158, 158)),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                        prefixIcon: const Icon(
                          Icons.search, 
                          color: Color.fromARGB(255, 11, 49, 62),
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(255, 204, 224, 230),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 7),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: PopupMenuButton<String>(
                    onSelected: (String selectedColor) {
                      setState(() {
                        _selectedColor = selectedColor;
                      });
                      provider.filterPokemonsByColor(_selectedColor); // Apply color filter
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(value: 'All', child: Text('All')),
                        const PopupMenuItem<String>(value: 'red', child: Text('Red')),
                        const PopupMenuItem<String>(value: 'blue', child: Text('Blue')),
                        const PopupMenuItem<String>(value: 'green', child: Text('Green')),
                        const PopupMenuItem<String>(value: 'yellow', child: Text('Yellow')),
                        const PopupMenuItem<String>(value: 'pink', child: Text('Pink')),
                        const PopupMenuItem<String>(value: 'black', child: Text('Black')),
                        const PopupMenuItem<String>(value: 'white', child: Text('White')),
                      ];
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.filter_list,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Display Pokémon List
          provider.loading
              ? const Center(child: CircularProgressIndicator())
              : Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16.0),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: provider.pokemons.length,
                    itemBuilder: (context, index) {
                      final pokemon = provider.pokemons[index];
                      return PokemonCard(pokemon: pokemon); // PokemonCard is a custom widget
                    },
                  ),
                ),
        ],
      ),
    );
  }
}


class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonCard({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getColorFromName(
          pokemon.color), // Background color based on Pokémon color
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pokémon image
          Image.network(
            pokemon.imageUrl,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error, size: 50),
          ),
          const SizedBox(height: 8),
          // Pokémon name and ID
          Text(
            pokemon.name.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            '${pokemon.id.toString().padLeft(3, '0')}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  // Helper function to map color names to Color values
  Color _getColorFromName(String colorName) {
    const Map<String, Color> colorMap = {
      'red': Color.fromARGB(255, 231, 175, 175), // Light red
      'blue': Color.fromARGB(255, 167, 195, 224), // Light blue
      'green': Color.fromARGB(255, 199, 233, 238), // Light green
      'yellow': Color(0xFFFFFF66), // Light yellow
      'pink': Color(0xFFFF99CC), // Light pink
      'black': Color(0xFFB3B3B3), // Light black (grayish)
      'white': Color(0xFFFFFFFF), // White remains the same
    };

    return colorMap[colorName.toLowerCase()] ?? Colors.grey; // Default to gray
  }
}


