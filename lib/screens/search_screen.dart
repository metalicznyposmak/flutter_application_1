import 'package:flutter/material.dart';
import 'package:flutter_application_1/categories_api.dart';
import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/screens/products_screen.dart';
import 'package:flutter_application_1/widgets/app_bottom_bar.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoriesApi().listCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategorie'),
      ),
      body: FutureBuilder<List<Category>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final categories = snapshot.data ?? const <Category>[];
          return ListView.separated(
            itemCount: categories.length,
            separatorBuilder: (_, __) => const Divider(height: 10),
            itemBuilder: (context, index) {
              final category = categories[index];
              return ListTile(
                title: Text(category.name,
                style: TextStyle(fontSize: 19)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductsScreen(
                        categoryId: category.id,
                        categoryName: category.name,
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
