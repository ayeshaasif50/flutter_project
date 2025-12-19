// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
// 👆 Ignore some Flutter linter warnings for const constructors and widget keys.

// Importing Flutter's material UI library
import 'package:flutter/material.dart';

// Importing detail page for individual menu items
import 'menu_detail_page.dart';

// Importing a custom Drawer widget (navigation sidebar)
import '../widgets/drawer.dart';

// Importing main.dart to access global variables like favorites & cart
import '../main.dart'; // 🩵 access globalFavorites & globalCart lists

// Creating a StatefulWidget named MenuPage
class MenuPage extends StatefulWidget {
  const MenuPage({super.key}); // Constructor with optional key

  @override
  State<MenuPage> createState() => _MenuPageState(); // Create its state
}

// State class for MenuPage (where UI updates happen)
class _MenuPageState extends State<MenuPage> {

  // 🔸 Keeps track of which category chip is selected
  String _selectedCategory = "All";

  // 🔸 Stores user input for search bar
  String _searchQuery = "";

  // 🔸 List of menu items (Coffee + Desserts)
  // Each item is a Map with title, price, image, and category
  final List<Map<String, dynamic>> _coffeeItems = [
    // ☕ HOT COFFEES
    {"title": "Cappuccino", "price": "\$4.50", "img": "assets/img.png", "category": "Hot"},
    {"title": "Latte", "price": "\$5.00", "img": "assets/img_1.png", "category": "Hot"},
    {"title": "Espresso", "price": "\$3.50", "img": "assets/img_2.png", "category": "Hot"},
    {"title": "Mocha", "price": "\$5.20", "img": "assets/img_3.png", "category": "Hot"},
    {"title": "Americano", "price": "\$4.00", "img": "assets/img_4.png", "category": "Hot"},
    {"title": "Macchiato", "price": "\$4.70", "img": "assets/img_5.png", "category": "Hot"},
    {"title": "Flat White", "price": "\$4.90", "img": "assets/img_6.png", "category": "Hot"},
    {"title": "Café au Lait", "price": "\$4.60", "img": "assets/img_7.png", "category": "Hot"},
    {"title": "Turkish Coffee", "price": "\$3.80", "img": "assets/img_8.png", "category": "Hot"},
    {"title": "Hazelnut Latte", "price": "\$5.30", "img": "assets/img_9.png", "category": "Hot"},

    // 🧊 COLD COFFEES
    {"title": "Iced Coffee", "price": "\$4.80", "img": "assets/img_10.png", "category": "Cold"},
    {"title": "Caramel Frappe", "price": "\$6.00", "img": "assets/img_11.png", "category": "Cold"},
    {"title": "Iced Latte", "price": "\$5.20", "img": "assets/img_12.png", "category": "Cold"},
    {"title": "Mocha Frappe", "price": "\$6.10", "img": "assets/img_13.png", "category": "Cold"},
    {"title": "Iced Americano", "price": "\$4.30", "img": "assets/img_14.png", "category": "Cold"},
    {"title": "Cold Brew", "price": "\$4.90", "img": "assets/img_15.png", "category": "Cold"},
    {"title": "Vanilla Sweet Cream Cold Brew", "price": "\$5.50", "img": "assets/img_16.png", "category": "Cold"},
    {"title": "Chocolate Iced Latte", "price": "\$5.60", "img": "assets/img_17.png", "category": "Cold"},
    {"title": "Pumpkin Spice Iced Coffee", "price": "\$5.80", "img": "assets/img_18.png", "category": "Cold"},
    {"title": "Iced Macchiato", "price": "\$5.00", "img": "assets/img_19.png", "category": "Cold"},

    // 🍰 DESSERTS
    {"title": "Brownie", "price": "\$2.50", "img": "assets/img_21.png", "category": "Dessert"},
    {"title": "Donut", "price": "\$2.00", "img": "assets/img_22.png", "category": "Dessert"},
    {"title": "Cheesecake", "price": "\$3.80", "img": "assets/img_23.png", "category": "Dessert"},
    {"title": "Chocolate Muffin", "price": "\$2.70", "img": "assets/img_24.png", "category": "Dessert"},
    {"title": "Croissant", "price": "\$2.30", "img": "assets/img_25.png", "category": "Dessert"},
    {"title": "Cinnamon Roll", "price": "\$3.20", "img": "assets/img_26.png", "category": "Dessert"},
    {"title": "Tiramisu", "price": "\$4.10", "img": "assets/img_27.png", "category": "Dessert"},
    {"title": "Macaron", "price": "\$3.50", "img": "assets/img_28.png", "category": "Dessert"},
    {"title": "Cupcake", "price": "\$2.80", "img": "assets/img_29.png", "category": "Dessert"},
    {"title": "Waffle", "price": "\$3.60", "img": "assets/img_30.png", "category": "Dessert"},
  ];

  @override
  Widget build(BuildContext context) {
    // 🔍 Filter list based on selected category and search query
    List<Map<String, dynamic>> filteredItems = _coffeeItems
        .where((item) =>
    (_selectedCategory == "All" || item["category"] == _selectedCategory) &&
        item["title"].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE0), // Light beige background

      // 🔸 App Bar
      appBar: AppBar(
        title: const Text("Our Menu ☕"),
        backgroundColor: const Color(0xFF8C6542), // Coffee-brown shade
        centerTitle: true, // Centered title
      ),

      // 🔸 Drawer (Side Navigation)
      drawer: const AppDrawer(),

      // 🔸 Body content of the page
      body: Column(
        children: [
          // 🔍 Search Bar Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value), // update state on typing
              decoration: InputDecoration(
                hintText: "Search your coffee...", // placeholder text
                prefixIcon: const Icon(Icons.search, color: Colors.brown),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none, // no border line
                ),
              ),
            ),
          ),

          // ☕ Horizontal category chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal, // chips in a row
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildCategoryChip("All"),
                _buildCategoryChip("Hot"),
                _buildCategoryChip("Cold"),
                _buildCategoryChip("Dessert"),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 🧃 Grid of Menu Items
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // two items per row
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 0.8, // adjust height ratio
              ),
              itemCount: filteredItems.length, // filtered items count
              itemBuilder: (context, index) {
                final item = filteredItems[index]; // current item
                final isFav = globalFavorites.any((fav) => fav["title"] == item["title"]); // check if favorite

                return GestureDetector(
                  onTap: () {
                    // On tap → navigate to detail page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MenuDetailPage(item: Map<String, dynamic>.from(item)),
                      ),
                    );
                  },
                  child: Stack( // To layer heart icon above the card
                    children: [
                      // ☕ Coffee card UI
                      Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        color: Colors.white,
                        elevation: 3,
                        shadowColor: Colors.brown.withOpacity(0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 📸 Image section
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                              child: Image.asset(
                                item["img"], // coffee image
                                height: 110,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // ☕ Coffee Name
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                item["title"],
                                style: const TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            // 💲 Price text
                            Text(
                              item["price"],
                              style: const TextStyle(color: Colors.black54, fontSize: 14),
                            ),
                            const SizedBox(height: 6),

                            // 🛒 Add to Cart Button
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  // Check if item already exists in globalCart
                                  final existingItem = globalCart.firstWhere(
                                        (cartItem) => cartItem['name'] == item['title'],
                                    orElse: () => {}, // if not found, return empty map
                                  );

                                  // If exists, increase quantity
                                  if (existingItem.isNotEmpty) {
                                    existingItem['quantity'] =
                                        (existingItem['quantity'] ?? 1) + 1;
                                  } else {
                                    // Else add new item to cart
                                    globalCart.add({
                                      'name': item['title'],
                                      'price': item['price'],
                                      'image': item['img'],
                                      'quantity': 1,
                                    });
                                  }

                                  // Show snackbar confirmation
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('${item["title"]} added to cart 🛒'),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8C6542), // brown color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
                              ),
                              child: const Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ❤️ Favorite heart icon
                      Positioned(
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isFav) {
                                // Remove from favorites
                                globalFavorites
                                    .removeWhere((fav) => fav["title"] == item["title"]);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item["title"]} removed 💔'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              } else {
                                // Add to favorites
                                globalFavorites.add({
                                  'title': item["title"],
                                  'subtitle': item["price"],
                                  'img': item["img"],
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${item["title"]} added ❤️'),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            });
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white.withOpacity(0.9),
                            child: Icon(
                              isFav ? Icons.favorite : Icons.favorite_border,
                              color: isFav ? Colors.red : Colors.brown,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 🔸 Reusable widget to build category chips (Hot, Cold, etc.)
  Widget _buildCategoryChip(String label) {
    final bool isSelected = _selectedCategory == label; // Check if active chip
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: ChoiceChip(
        label: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.brown,
            fontWeight: FontWeight.bold,
          ),
        ),
        selected: isSelected,
        selectedColor: const Color(0xFF8C6542), // Active chip color
        backgroundColor: Colors.white,
        onSelected: (selected) {
          // Update selected category on tap
          setState(() {
            _selectedCategory = label;
          });
        },
      ),
    );
  }
}
