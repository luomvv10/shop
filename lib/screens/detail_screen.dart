import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/cart_service.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  final CartService _cartService = CartService();

  @override
  Widget build(BuildContext context) {
    final Product product =
        ModalRoute.of(context)!.settings.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Chi tiết sản phẩm"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đã thêm vào yêu thích')),
              );
            },
          ),
        ],
      ),

      body: ListView(
        children: [

          // ===== IMAGE =====
          Container(
            height: 320, // ⭐ KHUNG BỰ
            width: double.infinity,
            color: Colors.grey[100],
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: product.imageAsset != null
                    ? Image.asset(
                        product.imageAsset!,
                        fit: BoxFit.contain, // ⭐ FULL ẢNH
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            product.image,
                            fit: BoxFit.contain,
                          );
                        },
                      )
                    : Image.network(
                        product.image,
                        fit: BoxFit.contain, // ⭐ FULL ẢNH
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          );
                        },
                      ),
              ),
            ),
          ),

          // ===== INFO =====
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // NAME
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                // RATING
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 20),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating} (${product.reviews} reviews)',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // CATEGORY
                Chip(
                  label: Text(product.category),
                  backgroundColor: Colors.deepOrange.withOpacity(0.1),
                  labelStyle: const TextStyle(color: Colors.deepOrange),
                ),

                const SizedBox(height: 16),

                // PRICE
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${(product.price / 1000).toStringAsFixed(0)}K đ',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // DESCRIPTION
                const Text(
                  'Mô tả sản phẩm',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.6,
                  ),
                ),

                const SizedBox(height: 24),

                // QUANTITY
                const Text(
                  'Số lượng',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) quantity--;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.remove),
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.add),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ],
      ),

      // ===== BUTTON =====
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            for (int i = 0; i < quantity; i++) {
              _cartService.addItem(product);
            }
            

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Đã thêm $quantity sản phẩm vào giỏ hàng',
                ),
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              Navigator.pop(context);
            });
          },
          child: const Text(
            'Thêm vào giỏ hàng',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}