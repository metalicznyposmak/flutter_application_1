import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/products_api.dart';
import 'package:flutter_application_1/widgets/app_bottom_bar.dart';
import 'package:flutter_application_1/screens/product_screen.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  const ProductsScreen({
    Key? key,
    required this.categoryId,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late final ProductsApi _productsApi;
  late final Future<List<Product>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsApi = ProductsApi();
    _productsFuture = _productsApi.listProducts(categoryId: widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Blad pobierania: ${snapshot.error}'),
            );
          }
          final products = snapshot.data ?? const <Product>[];
          if (products.isEmpty) {
            return const Center(child: Text('Brak produktow'));
          }
          return ListView.separated(
            itemCount: products.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: _ProductImage(url: product.imageUrl, ),
                title: Text(product.name),
                subtitle: Text(product.price.toStringAsFixed(2)+' zł'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductScreen(
                        productId: product.id,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: const AppBottomBar(current: AppSection.search),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String url;

  const _ProductImage({required this.url});

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
        width: 120,
        height: 120,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox(
          width: 120,
          height: 120,
          child: Icon(Icons.broken_image),
        ),
      ),
    );
  }
}
