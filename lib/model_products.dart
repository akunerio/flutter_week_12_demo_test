import 'dart:convert';

class Products {
  final String name;
  final int price;

  const Products({
    required this.name,
    required this.price,
  });

  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      name: json['name'],
      price: json['price'],
    );
  }
}

// make list from data model products
List<Products> parseProducts(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Products>((json) => Products.fromJson(json)).toList();
}