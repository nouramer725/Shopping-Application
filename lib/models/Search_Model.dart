class SearchModel {
  bool? status;
  String? message; // Use String? to allow null messages
  Data? data; // Data can be null

  SearchModel.fromJson(Map<String,dynamic> json) {
    status = json['status'];
    message = json['message']?.toString(); // Safely convert to String or null
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl; // Can be null
  String? path;
  int? perPage;
  String?prevPageUrl; // Can be null
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    data = (json['data'] as List?)?.map((v) => Product.fromJson(v)).toList() ?? []; // Handle null and empty lists
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url']?.toString(); // Safely convert to String
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url']?.toString(); // Safely convert to String
    to = json['to'];
    total = json['total'];
  }
}


class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;
  String? description;

  Product({
    required this.id,
    required this.price,
    required this.oldPrice,
    required this.discount,
    required this.image,
    required this.name,
    required this.description,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['discount'] = this.discount;
    data['image'] = this.image;
    data['name'] = this.name;
    data['description'] = this.description;
    return data;
  }
}