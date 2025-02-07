class ProductModel {
  int? id;
  String? title;
  double? price; 
  String? description;
  String? category;
  String? image;
  Rating? rating;

  ProductModel(
      {this.id,
      this.title,
      this.price,
      this.description,
      this.category,
      this.image,
      this.rating});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = _parsePrice(json['price']); 
    description = json['description'];
    category = json['category'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  // Helper function to handle conversion of price and rate
  static double? _parsePrice(dynamic price) {
    if (price is int) {
      return price.toDouble(); 
    } else if (price is double) {
      return price; 
    } else {
      return null; 
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['category'] = this.category;
    data['image'] = this.image;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    return data;
  }
}

class Rating {
  double? rate;
  int? count;

  Rating({this.rate, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    rate = _parseRate(json['rate']); // Handle type conversion for rate
    count = json['count'];
  }

  // Helper function to handle conversion of rate
  static double? _parseRate(dynamic rate) {
    if (rate is int) {
      return rate.toDouble(); // Convert int to double
    } else if (rate is double) {
      return rate; // If it's already a double, return it
    } else {
      return null; // Return null if the value is neither int nor double
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = this.rate;
    data['count'] = this.count;
    return data;
  }
}
