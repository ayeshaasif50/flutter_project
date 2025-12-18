import 'package:flutter/material.dart';
import '../main.dart'; // globalOrders

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'In Transit':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        centerTitle: true,
        backgroundColor: const Color(0xFF8C6542),
      ),
      body: globalOrders.isEmpty
          ? const Center(
        child: Text(
          "No orders found",
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: globalOrders.length,
        itemBuilder: (context, index) {
          final order = globalOrders[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: Icon(
                Icons.local_cafe,
                color: _getStatusColor(order['status']),
                size: 30,
              ),
              title: Text(
                order['name'] ?? '',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Qty: ${order['quantity']} • Date: ${order['date']}",
              ),
              trailing: Text(
                order['status'] ?? '',
                style: TextStyle(
                  color: _getStatusColor(order['status']),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
