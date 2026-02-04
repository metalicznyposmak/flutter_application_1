class CartItem {
  final int productId;
  final String name;
  final int quantity;
  final double unitPrice;
  final double lineTotal;
  final String imageUrl;

  const CartItem({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.unitPrice,
    required this.lineTotal,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    final unitPriceValue = json['unitPrice'];
    final lineTotalValue = json['lineTotal'];
    return CartItem(
      productId: (json['productId'] as num?)?.toInt() ?? 0,
      name: json['name']?.toString() ?? '',
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      unitPrice: unitPriceValue is num ? unitPriceValue.toDouble() : 0.0,
      lineTotal: lineTotalValue is num ? lineTotalValue.toDouble() : 0.0,
      imageUrl: json['imageUrl']?.toString() ?? '',
    );
  }
}

class Cart {
  final int cartId;
  final String status;
  final List<CartItem> items;
  final double total;

  const Cart({
    required this.cartId,
    required this.status,
    required this.items,
    required this.total,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    final itemsData = json['items'];
    final totalValue = json['total'];
    return Cart(
      cartId: (json['cartId'] as num?)?.toInt() ?? 0,
      status: json['status']?.toString() ?? '',
      items: itemsData is List
          ? itemsData
              .whereType<Map<String, dynamic>>()
              .map(CartItem.fromJson)
              .toList()
          : const <CartItem>[],
      total: totalValue is num ? totalValue.toDouble() : 0.0,
    );
  }
}
