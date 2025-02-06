import 'package:cloud_firestore/cloud_firestore.dart';

class Order1 {
  bool available;
  String buyerAddress;
  String buyerPhone;
  String cardHolderId;
  DateTime createdAt;
  List<ImageUrl> imageUrl;
  String id;
  String productId;
  String productName;
  double productPrice;
  String productUrl;
  String status;
  String userId;

  Order1({
    required this.available,
    required this.buyerAddress,
    required this.buyerPhone,
    required this.cardHolderId,
    required this.createdAt,
    required this.imageUrl,
    required this.id,
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.productUrl,
    required this.status,
    required this.userId,
  });

  // Factory method to create an Order from a Map
  factory Order1.fromJson(Map<String, dynamic> json) {
    var imageList = <ImageUrl>[];
    if (json['imageUrl'] != null) {
      json['imageUrl'].forEach((v) {
        imageList.add(ImageUrl.fromJson(v));
      });
    }
    
    return Order1(
      available: json['available'] ?? false,
      buyerAddress: json['buyer_address'] ?? '',
      buyerPhone: json['buyer_phone'] ?? '',
      cardHolderId: json['cardHolderId'] ?? '',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      imageUrl: imageList,
      id: json['id'] ?? '',
      productId: json['productId'] ?? '',
      productName: json['product_name'] ?? 'Loading...',
      productPrice: json['product_price'] ?? 0.0,
      productUrl: json['product_url'] ?? '',
      status: json['status'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  // Method to convert the Order object to a Map
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> imageList = [];
    imageUrl.forEach((v) {
      imageList.add(v.toJson());
    });

    return {
      'available': available,
      'buyer_address': buyerAddress,
      'buyer_phone': buyerPhone,
      'cardHolderId': cardHolderId,
      'createdAt': createdAt,
      'imageUrl': imageList,
      'id': id,
      'productId': productId,
      'product_name': productName,
      'product_price': productPrice,
      'product_url': productUrl,
      'status': status,
      'userId': userId,
    };
  }
}

class ImageUrl {
  String id;
  String url;

  ImageUrl({
    required this.id,
    required this.url,
  });

  // Factory method to create ImageUrl from a Map
  factory ImageUrl.fromJson(Map<String, dynamic> json) {
    return ImageUrl(
      id: json['id'] ?? '',
      url: json['url'] ?? '',
    );
  }

  // Method to convert ImageUrl to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}
