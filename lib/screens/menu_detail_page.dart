// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors
// ⚙️ Ye ignore statements Dart linter warnings ko ignore karte hain.
// 'prefer_const_constructors' - const use karne ki warning ignore karega.
// 'use_key_in_widget_constructors' - jab hum constructor me key nahi dete to warning ignore karega.

import 'package:flutter/material.dart';
// 📦 Flutter Material Design package import karta hai.

import '../main.dart';
// ✅ globalCart variable ko access karne ke liye main.dart file import ki gayi hai.


// 🌟 Stateful Widget (kyunki quantity badal sakti hai)
class MenuDetailPage extends StatefulWidget {
  final Map<String, dynamic> item; // Har item ke data (name, price, image, etc.)

  const MenuDetailPage({required this.item});

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}


// 🔽 State class — yahan saara UI aur logic likha gaya hai
class _MenuDetailPageState extends State<MenuDetailPage> {
  int _quantity = 1; // 🔢 Starting quantity 1 set ki gayi hai.

  // ☕ Item ke detailed descriptions store karne ke liye map
  final Map<String, String> _itemDescriptions = {
    "Cappuccino": "A classic Italian coffee made with rich espresso, steamed milk, and a layer of frothy foam.",
    "Latte": "Smooth espresso blended with steamed milk and a light layer of foam for a creamy texture.",
    "Espresso": "A strong, bold shot of pure coffee essence — intense and aromatic.",
    "Mocha": "A delightful mix of espresso, chocolate, and steamed milk topped with whipped cream.",
    "Americano": "Espresso diluted with hot water for a smoother, less intense flavor.",
    "Macchiato": "Espresso topped with a small amount of milk foam — strong yet silky.",
    "Flat White": "Velvety microfoam poured over rich espresso — creamy and balanced.",
    "Café au Lait": "Equal parts of brewed coffee and steamed milk — smooth and light.",
    "Turkish Coffee": "Finely ground coffee boiled with sugar — traditional and full-bodied flavor.",
    "Hazelnut Latte": "A nutty twist on the classic latte with smooth hazelnut flavor.",
    "Iced Coffee": "Chilled brewed coffee served over ice — simple, bold, and refreshing.",
    "Caramel Frappe": "A creamy frozen blend of coffee, caramel syrup, and ice — sweet perfection.",
    "Iced Latte": "Cool espresso mixed with milk and ice — light and refreshing.",
    "Mocha Frappe": "Blended iced coffee with chocolate and milk, topped with whipped cream.",
    "Iced Americano": "Espresso with cold water and ice — bold yet smooth.",
    "Cold Brew": "Steeped for hours, this smooth cold coffee has natural sweetness and low acidity.",
    "Vanilla Sweet Cream Cold Brew": "Silky vanilla cream poured over smooth cold brew coffee.",
    "Chocolate Iced Latte": "A chocolatey twist on the iced latte with a touch of cocoa sweetness.",
    "Pumpkin Spice Iced Coffee": "Iced coffee with a fall-inspired pumpkin spice flavor.",
    "Iced Macchiato": "Espresso poured over milk and ice — beautifully layered and refreshing.",
    "Brownie": "Rich, fudgy chocolate brownie baked to perfection.",
    "Donut": "Soft and fluffy donut glazed with sweetness.",
    "Cheesecake": "Creamy cheesecake with a buttery crust — indulgence in every bite.",
    "Chocolate Muffin": "Moist chocolate muffin loaded with choco chips.",
    "Croissant": "Flaky French pastry — buttery, light, and perfect with coffee.",
    "Cinnamon Roll": "Warm, gooey roll topped with creamy icing and cinnamon swirl.",
    "Tiramisu": "Classic Italian dessert made with espresso-soaked layers and mascarpone cream.",
    "Macaron": "Delicate French almond cookies with soft creamy centers.",
    "Cupcake": "Soft sponge cake with creamy frosting — simple and sweet.",
    "Waffle": "Crispy golden waffle with a soft center — perfect with syrup or ice cream.",
  };

  @override
  Widget build(BuildContext context) {
    final item = widget.item; // 🔹 Widget se selected item data access kiya gaya hai.

    // ✅ Name, Price, Image safe tarike se extract kar rahe hain (fallbacks ke sath)
    final String itemName = item['name'] ?? item['title'] ?? 'Unknown Item';
    final String itemPrice = item['price'] ?? item['subtitle'] ?? '\$0.00';
    final String itemImage = item['image'] ?? item['img'] ?? '';

    // 📄 Description map se liya gaya, agar na mile to default text dikhata hai.
    final String description =
        _itemDescriptions[itemName] ?? 'A delicious treat to make your day better! ☕';

    // 🏗️ Scaffold — poori page structure banata hai (AppBar, Body, Background)
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4E0), // ☕ Light coffee theme background

      // ☕ Top App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF8C6542), // Brown color
        title: Text(
          itemName, // Item name show hoga title me
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Back arrow color white
        centerTitle: true, // Title center me
      ),

      // 📜 Scrollable Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0), // Body ke around padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 📷 Product Image Show
            if (itemImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(20), // Image corners round
                child: Image.asset(
                  itemImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover, // Image fill kare poora area
                ),
              ),
            const SizedBox(height: 20),

            // ☕ Item Name (Big Bold)
            Text(
              itemName,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.brown[800],
              ),
            ),
            const SizedBox(height: 8),

            // 💰 Item Price
            Text(
              itemPrice,
              style: TextStyle(
                fontSize: 22,
                color: Colors.brown[600],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),

            // 📝 Item Description
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.brown[700]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            // 🔢 Quantity Selector Row (Minus, Number, Plus)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildQuantityButton(Icons.remove, () {
                  // ➖ Quantity decrease (min = 1)
                  if (_quantity > 1) setState(() => _quantity--);
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '$_quantity', // Current quantity show
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                ),
                _buildQuantityButton(Icons.add, () {
                  // ➕ Quantity increase
                  setState(() => _quantity++);
                }),
              ],
            ),
            const SizedBox(height: 40),

            // 🛒 Add to Cart Button
            ElevatedButton.icon(
              onPressed: () {
                // ✅ Add selected item to global cart (main.dart me defined list)
                globalCart.add({
                  'name': itemName,
                  'price': itemPrice,
                  'image': itemImage,
                  'quantity': _quantity,
                });

                // ✅ Confirmation message SnackBar me show karte hain
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "$itemName x$_quantity added to cart 🛍️",
                      style: TextStyle(fontSize: 16),
                    ),
                    backgroundColor: Color(0xFF8C6542), // Brown background
                    behavior: SnackBarBehavior.floating, // Floating style message
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart, color: Colors.white), // White cart icon
              label: const Text(
                "Add to Cart",
                style: TextStyle(
                  color: Colors.white, // White text
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8C6542), // Brown background color
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Rounded corners
                ),
                elevation: 5, // Light shadow
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔘 Reusable Function: Quantity Button Design (Add/Remove Buttons)
  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.brown[100], // Light brown circle background
        shape: BoxShape.circle, // Button circle shape
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.brown[800]), // Icon color
        onPressed: onPressed, // Function run jab press hota hai
      ),
    );
  }
}
