import '../models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });
}

class CartManager {
  static final List<CartItem> _items = [];

  static List<CartItem> get items => _items;

  static void add(Product product) {
    final index = _items.indexWhere((e) => e.product.id == product.id);

    if (index >= 0) {
      _items[index].quantity++;
    } else {
      _items.add(CartItem(product: product));
    }
  }

  static void remove(Product product) {
    final index = _items.indexWhere((e) => e.product.id == product.id);

    if (index == -1) return;

    if (_items[index].quantity > 1) {
      _items[index].quantity--;
    } else {
      _items.removeAt(index);
    }
  }

  static void clear() {
    _items.clear();
  }
}