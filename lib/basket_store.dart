import 'models/product.dart';

class BasketStore {
  static final List<Product> _items = <Product>[];

  static List<Product> get items => List.unmodifiable(_items);

  static void add(Product product) {
    _items.add(product);
  }
}
