import 'package:flutter/material.dart';
import '../services/cart_manager.dart';

class CustomCartCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;

  const CustomCartCard({
    super.key,
    required this.item,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: Image.network(
          item.product.image,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        ),

        title: Text(item.product.name),

        subtitle: Text("Quantity: ${item.quantity}"),

        trailing: IconButton(
          icon: const Icon(Icons.remove_circle, color: Colors.red),
          onPressed: onRemove,
        ),
      ),
    );
  }
}