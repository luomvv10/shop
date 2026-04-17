import '../models/cart_item.dart';
import '../models/product.dart';

class CartService {
  static final CartService _instance = CartService._internal();

  final List<CartItem> _items = [];

  CartService._internal();

  factory CartService() {
    return _instance;
  }

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  int get totalQuantity =>
      _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.totalPrice);

  void addItem(Product product) {
    final existingIndex =
        _items.indexWhere((item) => item.product.id == product.id);

    if (existingIndex >= 0) {
      _items[existingIndex].increaseQuantity();
    } else {
      _items.add(CartItem(product: product));
    }
  }

  void removeItem(CartItem item) {
    _items.remove(item);
  }

  void updateQuantity(CartItem item, int quantity) {
    if (quantity <= 0) {
      removeItem(item);
    } else {
      item.quantity = quantity;
    }
  }

  void clear() {
    _items.clear();
  }

  bool isEmpty() {
    return _items.isEmpty;
  }
}
