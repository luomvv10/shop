class Product {
  final int id;
  final String name;
  final String image;
  final String? imageAsset; // Local image path, e.g., 'assets/images/product_1.jpg'
  final double price;
  final String description;
  final String category;
  final double rating;
  final int reviews;

  Product({
    required this.id,
    required this.name,
    required this.image,
    this.imageAsset,
    required this.price,
    required this.description,
    required this.category,
    this.rating = 4.5,
    this.reviews = 0,
  });
}
