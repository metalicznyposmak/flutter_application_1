import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart_api.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/products_api.dart';
import 'package:flutter_application_1/widgets/app_bottom_bar.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late Future<Cart> _cartFuture;
  final Map<int, Future<Product>> _productFutures = {};

  @override
  void initState() {
    super.initState();
    _cartFuture = CartApi().getCart();
  }

  Future<Product> _getProduct(int productId) {
    return _productFutures.putIfAbsent(
      productId,
      () => ProductsApi().getProduct(productId: productId),
    );
  }

  Future<void> _removeItem(int productId) async {
    try {
      final cart = await CartApi().removeItem(productId: productId);
      if (!mounted) return;
      setState(() {
        _cartFuture = Future.value(cart);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Blad usuwania: $e')),
      );
    }
  }

  Future<void> _setQuantity(int productId, int quantity) async {
    if (quantity < 1) {
      await _removeItem(productId);
      return;
    }
    try {
      final cart = await CartApi().setItemQuantity(
        productId: productId,
        quantity: quantity,
      );
      if (!mounted) return;
      setState(() {
        _cartFuture = Future.value(cart);
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Blad zmiany ilosci: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Koszyk'),
      ),
      body: FutureBuilder<Cart>(
        future: _cartFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Blad pobierania: ${snapshot.error}'),
            );
          }
          final cart = snapshot.data;
          if (cart == null || cart.items.isEmpty) {
            return const Center(child: Text('Koszyk jest pusty'));
          }
          return ListView.separated(
            itemCount: cart.items.length + 1,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              if (index == cart.items.length) {
                return ListTile(
                  title: const Text('Razem'),
                  trailing: Text(cart.total.toStringAsFixed(2)),
                );
              }
              final item = cart.items[index];
              return ListTile(
                leading: _CartItemImageFuture(
                  productFuture: _getProduct(item.productId),
                ),
                title: Text(item.name),
                subtitle: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () =>
                          _setQuantity(item.productId, item.quantity - 1),
                    ),
                    Text('Ilosc: ${item.quantity}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () =>
                          _setQuantity(item.productId, item.quantity + 1),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(item.lineTotal.toStringAsFixed(2)),
                    IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _removeItem(item.productId),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const AppBottomBar(current: AppSection.basket),
    );
  }
}

class _CartItemImage extends StatelessWidget {
  final String url;

  const _CartItemImage({required this.url});

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const SizedBox(
        width: 56,
        height: 56,
        child: Icon(Icons.image_not_supported),
      );
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Image.network(
        url,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox(
          width: 56,
          height: 56,
          child: Icon(Icons.broken_image),
        ),
      ),
    );
  }
}

class _CartItemImageFuture extends StatelessWidget {
  final Future<Product> productFuture;

  const _CartItemImageFuture({required this.productFuture});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Product>(
      future: productFuture,
      builder: (context, snapshot) {
        final url = snapshot.data?.imageUrl ?? '';
        return _CartItemImage(url: url);
      },
    );
  }
}
