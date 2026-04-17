import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../widgets/product_card.dart';
import '../services/cart_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = 'Tất cả';
  final List<String> categories = [
    'Tất cả',
    'Áo',
    'Quần',
    'Giày',
    'Phụ Kiện',
    'Túi'
  ];

  final CartService _cartService = CartService();

 @override
Widget build(BuildContext context) {
  final filteredProducts = selectedCategory == 'Tất cả'
      ? dummyProducts
      : dummyProducts
          .where((p) => p.category == selectedCategory)
          .toList();

  return Scaffold(
    backgroundColor: Colors.grey[100],

    // ===== APPBAR =====
    appBar: AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.orange],
          ),
        ),
      ),
      title: const Text(
        'Shop Online',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none),
          onPressed: () {},
        )
      ],
    ),

    body: Column(
      children: [

        // ===== SEARCH =====
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Tìm kiếm sản phẩm...',
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),

        // ===== CATEGORY =====
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = category == selectedCategory;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCategory = category;
                  });
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Colors.deepOrange, Colors.orange],
                          )
                        : null,
                    color: isSelected ? null : Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      if (isSelected)
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.4),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        )
                    ],
                  ),
                  child: Center(
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // ===== PRODUCT GRID =====
        Expanded(
          child: filteredProducts.isEmpty
              ? Center(
                  child: Text(
                    'Không có sản phẩm',
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 80),
                  itemCount: filteredProducts.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final product = filteredProducts[index];

                    return ProductCard(
                      product: product,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/detail',
                          arguments: product,
                        ).then((_) {
                          setState(() {});
                        });
                      },
                    );
                  },
                ),
        ),
      ],
    ),

    // ===== FLOATING CART =====
    floatingActionButton: Stack(
      children: [
        FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          onPressed: () {
            Navigator.pushNamed(context, '/cart').then((_) {
              setState(() {});
            });
          },
          child: const Icon(Icons.shopping_cart),
        ),

        // Badge
        if (_cartService.totalQuantity > 0)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Text(
                _cartService.totalQuantity.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          )
      ],
    ),
  );
}
}