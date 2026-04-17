import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatefulWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final VoidCallback onUpdate;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onUpdate,
  });

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[200],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: widget.item.product.imageAsset != null
                    ? Image.asset(
                        widget.item.product.imageAsset!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            widget.item.product.image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.image, color: Colors.grey);
                            },
                          );
                        },
                      )
                    : Image.network(
                        widget.item.product.image,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.image, color: Colors.grey);
                        },
                      ),
              ),
            ),
            const SizedBox(width: 12),
            // Product Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(widget.item.product.price / 1000).toStringAsFixed(0)}K đ',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Quantity Control
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.item.decreaseQuantity();
                          });
                          widget.onUpdate();
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.remove, size: 14),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                        child: Center(
                          child: Text(
                            '${widget.item.quantity}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.item.increaseQuantity();
                          });
                          widget.onUpdate();
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.add, size: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${(widget.item.totalPrice / 1000).toStringAsFixed(0)}K đ',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onRemove,
                  child: const Icon(Icons.delete, color: Colors.red, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
