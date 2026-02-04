class Category {
  final int id;
  final String name;

  const Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    final idValue = json['id'];
    final nameValue = json['name'];

    return Category(
      id: idValue is num ? idValue.toInt() : 0,
      name: nameValue?.toString() ?? '',
    );
  }
}
