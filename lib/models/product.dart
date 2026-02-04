class Product {
  final int id;
  final int categoryId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final bool isActive;

  const Product({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isActive,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final priceValue = json['price'];
    return Product(
      id: (json['id'] as num?)?.toInt() ?? 0,
      categoryId: (json['categoryId'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: priceValue is num ? priceValue.toDouble() : 0.0,
      imageUrl: json['imageUrl']?.toString() ?? '',
      isActive: json['isActive'] == true,
    );
  }
}
