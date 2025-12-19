// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../main.dart'; // Access globalCart and globalOrders

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var item in cartItems) {
      double price = double.tryParse(
        item['price']?.toString().replaceAll('\$', '').trim() ?? '0',
      ) ?? 0;
      total += price * (item['quantity'] ?? 1);
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF5EDE0),
      appBar: AppBar(
        title: const Text(
          'Your Cart 🛒',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        backgroundColor: const Color(0xFF8C6542),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: cartItems.isEmpty
            ? _buildEmptyCart(context)
            : _buildCartList(context, total),
      ),
      floatingActionButton: cartItems.isNotEmpty
          ? FloatingActionButton.extended(
        onPressed: () {
          // ✅ Add cart items to globalOrders
          for (var item in cartItems) {
            globalOrders.add({
              'name': item['name'],
              'price': item['price'],
              'quantity': item['quantity'] ?? 1,
              'date': DateTime.now().toString().split(' ')[0],
              'status': 'Pending',
            });
          }

          // ✅ Clear cart after checkout
          cartItems.clear();
          globalCart.clear();

          // Show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content:
              Text("Checkout successful! Orders added to history."),
              behavior: SnackBarBehavior.floating,
            ),
          );

          // Refresh page
          (context as Element).reassemble();
        },
        backgroundColor: Colors.brown[400],
        icon: const Icon(Icons.payment, color: Colors.white),
        label: const Text(
          "Checkout",
          style:
          TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 100),
        Icon(Icons.shopping_cart_outlined, size: 90, color: Colors.brown[300]),
        const SizedBox(height: 16),
        Text("Your cart is empty",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.brown[700])),
        const SizedBox(height: 8),
        Text(
          "Add some delicious coffee and snacks to get started!",
          style: TextStyle(fontSize: 15, color: Colors.brown[500]),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.brown[400],
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          ),
          child: const Text(
            "Browse Menu",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildCartList(BuildContext context, double total) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Review your order before checkout ☕🍰",
              style:
              TextStyle(fontSize: 16, color: Colors.brown, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            ...cartItems.map((item) {
              final itemName = item['name']?.toString() ?? 'Unknown Item';
              final itemPrice = item['price']?.toString() ?? '\$0';
              final itemImage = item['image']?.toString() ?? '';
              final quantity = item['quantity'] ?? 1;

              final parsedPrice = double.tryParse(itemPrice.replaceAll('\$', '')) ?? 0;
              final itemTotal = parsedPrice * quantity;

              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8EE),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: itemImage.isNotEmpty
                          ? Image.asset(
                        itemImage,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.coffee, color: Colors.brown, size: 50),
                      )
                          : Icon(Icons.coffee, color: Colors.brown, size: 50),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(itemName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown,
                                  fontSize: 16)),
                          const SizedBox(height: 5),
                          Text("$itemPrice × $quantity",
                              style: TextStyle(color: Colors.brown[600], fontSize: 14)),
                        ],
                      ),
                    ),
                    Text("\$${itemTotal.toStringAsFixed(2)}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.brown, fontSize: 16)),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.brown[100],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total:",
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
                  Text("\$${total.toStringAsFixed(2)}",
                      style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.brown)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            Center(
              child: Text(
                "☕ Coffee Enyong - Happiness in every sip",
                style: TextStyle(
                    fontSize: 13, color: Colors.brown[400], fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
