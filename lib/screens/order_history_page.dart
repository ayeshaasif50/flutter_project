import 'package:flutter/material.dart';

class OrderHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> orders = [
    {
      'orderId': 'ORD12345',
      'date': 'Oct 10, 2025',
      'total': 2499.00,
      'status': 'Delivered',
      'items': [
        {'name': 'Nike Shoes', 'quantity': 1, 'price': 1999.0},
        {'name': 'Socks Pack', 'quantity': 1, 'price': 500.0},
      ],
    },
    {
      'orderId': 'ORD12346',
      'date': 'Oct 05, 2025',
      'total': 1399.00,
      'status': 'In Transit',
      'items': [
        {'name': 'T-Shirt', 'quantity': 2, 'price': 699.5},
      ],
    },
    {
      'orderId': 'ORD12347',
      'date': 'Sep 28, 2025',
      'total': 899.00,
      'status': 'Cancelled',
      'items': [
        {'name': 'Cap', 'quantity': 1, 'price': 899.0},
      ],
    },
  ];

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

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Delivered':
        return Icons.check_circle;
      case 'In Transit':
        return Icons.local_shipping;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
        centerTitle: true,
      ),
      body: orders.isEmpty
          ? const Center(
        child: Text(
          'No orders found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.all(12),
              leading: Icon(
                _getStatusIcon(order['status']),
                color: _getStatusColor(order['status']),
                size: 32,
              ),
              title: Text(
                'Order #${order['orderId']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                '${order['date']} • Total: Rs. ${order['total'].toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              trailing: Text(
                order['status'],
                style: TextStyle(
                  color: _getStatusColor(order['status']),
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Column(
                    children: order['items']
                        .map<Widget>(
                          (item) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        title: Text(item['name']),
                        subtitle: Text('Qty: ${item['quantity']}'),
                        trailing: Text(
                          'Rs. ${item['price'].toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        },
      ),
    );
  }
}
