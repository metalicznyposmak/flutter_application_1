import 'package:flutter/material.dart';
import 'package:flutter_application_1/cart_api.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:flutter_application_1/products_api.dart';
import 'package:flutter_application_1/widgets/app_bottom_bar.dart';

class ProductScreen extends StatelessWidget {
  final int productId;

  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Product>(
        future: ProductsApi().getProduct(productId: productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final product = snapshot.data;
          if (product == null) {
            return const Center(child: Text('Brak produktu'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (product.imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  product.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(product.price.toStringAsFixed(2) + ' zł'),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        await CartApi().addItem(productId: product.id);
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Dodano do koszyka')),
                        );
                      } catch (e) {
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Błąd koszyka: $e')),
                        );
                      }
                    },
                    child: const Text('Dodaj do koszyka'),
                  ),
                ),
                const SizedBox(height: 16),
                Text(product.description),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomBar(current: AppSection.search),
    );
  }
}
