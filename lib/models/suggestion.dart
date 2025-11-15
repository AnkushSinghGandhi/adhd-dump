class AnimeSuggestion {
  final String id;
  final String title;
  final String posterUrl;
  final String season;
  final dynamic episodes;
  final double rating;
  final String airingDate;
  final String status;

  AnimeSuggestion({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.season,
    required this.episodes,
    required this.rating,
    required this.airingDate,
    required this.status,
  });

  factory AnimeSuggestion.fromJson(Map<String, dynamic> json) {
    return AnimeSuggestion(
      id: json['id'] as String,
      title: json['title'] as String,
      posterUrl: json['posterUrl'] as String,
      season: json['season'] as String,
      episodes: json['episodes'],
      rating: (json['rating'] as num).toDouble(),
      airingDate: json['airingDate'] as String,
      status: json['status'] as String,
    );
  }
}

class ShoppingSuggestion {
  final String id;
  final String productName;
  final String bestPrice;
  final List<Merchant> merchants;
  final String imageUrl;

  ShoppingSuggestion({
    required this.id,
    required this.productName,
    required this.bestPrice,
    required this.merchants,
    required this.imageUrl,
  });

  factory ShoppingSuggestion.fromJson(Map<String, dynamic> json) {
    return ShoppingSuggestion(
      id: json['id'] as String,
      productName: json['productName'] as String,
      bestPrice: json['bestPrice'] as String,
      merchants: (json['merchants'] as List)
          .map((m) => Merchant.fromJson(m as Map<String, dynamic>))
          .toList(),
      imageUrl: json['imageUrl'] as String,
    );
  }
}

class Merchant {
  final String name;
  final String price;
  final String logo;

  Merchant({
    required this.name,
    required this.price,
    required this.logo,
  });

  factory Merchant.fromJson(Map<String, dynamic> json) {
    return Merchant(
      name: json['name'] as String,
      price: json['price'] as String,
      logo: json['logo'] as String,
    );
  }
}

class StudySuggestion {
  final String id;
  final String title;
  final String resourceUrl;
  final String duration;
  final String thumbnail;
  final String type;

  StudySuggestion({
    required this.id,
    required this.title,
    required this.resourceUrl,
    required this.duration,
    required this.thumbnail,
    required this.type,
  });

  factory StudySuggestion.fromJson(Map<String, dynamic> json) {
    return StudySuggestion(
      id: json['id'] as String,
      title: json['title'] as String,
      resourceUrl: json['resourceUrl'] as String,
      duration: json['duration'] as String,
      thumbnail: json['thumbnail'] as String,
      type: json['type'] as String,
    );
  }
}
