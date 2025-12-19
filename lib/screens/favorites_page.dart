// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart'; // Import Flutter UI package
import '../main.dart'; // Import main.dart to use globalFavorites list

class FavoritesPage extends StatefulWidget { // Create a StatefulWidget for favorites page
  const FavoritesPage({super.key}); // Constructor

  @override
  State<FavoritesPage> createState() => _FavoritesPageState(); // Create state object
}

class _FavoritesPageState extends State<FavoritesPage> { // State class starts
  @override
  Widget build(BuildContext context) { // Build UI
    final darkBrown = const Color(0xFF8C6542); // Define dark brown color
    final bg = const Color(0xFFF5EDE0); // Define background color

    return Scaffold( // Main screen layout
      backgroundColor: bg, // Set background color
      appBar: AppBar( // Create app bar
        backgroundColor: darkBrown, // App bar color
        title: const Text( // App bar title text
          "Your Favorites ❤️", // Title text
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white), // Text style
        ),
        centerTitle: true, // Center the title
      ),

      body: globalFavorites.isEmpty // Check if favorites list is empty
          ? const Center( // If empty, show this widget
        child: Text( // Display message
          "No favorites yet ☕", // Message text
          style: TextStyle( // Text style
            fontSize: 18, // Font size
            color: Colors.brown, // Text color
            fontWeight: FontWeight.w500, // Text weight
          ),
        ),
      )
          : ListView.builder( // If not empty, show list of items
        padding: const EdgeInsets.all(16), // Add padding around list
        itemCount: globalFavorites.length, // Number of items in list
        itemBuilder: (context, index) { // Build each list item
          final item = globalFavorites[index]; // Get current favorite item

          return Card( // Create a card for each item
            margin: const EdgeInsets.symmetric(vertical: 10), // Add vertical margin
            color: Colors.brown[50], // Light brown card color
            shape: RoundedRectangleBorder( // Card shape
              borderRadius: BorderRadius.circular(14), // Rounded corners
            ),
            elevation: 3, // Add slight shadow
            child: ListTile( // Create a list tile inside the card
              leading: ClipRRect( // For rounded image corners
                borderRadius: BorderRadius.circular(12), // Round image corners
                child: Image.asset( // Display image
                  item['img'] ?? '', // Image path
                  width: 60, // Image width
                  height: 60, // Image height
                  fit: BoxFit.cover, // Fit image nicely
                  errorBuilder: (_, __, ___) => Container( // If image not found
                    width: 60, // Container width
                    height: 60, // Container height
                    color: Colors.brown[200], // Background color
                    child: const Icon(Icons.coffee, color: Colors.white), // Show coffee icon
                  ),
                ),
              ),
              title: Text( // Display title text
                item['title'] ?? 'Coffee', // Coffee name
                style: TextStyle( // Title text style
                  color: darkBrown, // Text color
                  fontWeight: FontWeight.bold, // Bold text
                ),
              ),
              subtitle: Text( // Display subtitle text
                item['subtitle'] ?? '', // Subtitle from list
                style: TextStyle(color: darkBrown.withOpacity(0.8)), // Subtitle style
              ),
              trailing: IconButton( // Button on right side
                icon: const Icon(Icons.delete_outline, color: Colors.redAccent), // Delete icon
                onPressed: () { // When delete button pressed
                  setState(() { // Update UI
                    globalFavorites.removeAt(index); // Remove item from list
                  });
                  ScaffoldMessenger.of(context).showSnackBar( // Show small popup
                    SnackBar( // Snackbar widget
                      content: Text('${item['title']} removed from favorites 💔'), // Message text
                      duration: const Duration(seconds: 1), // Duration of message
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
