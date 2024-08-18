class HotelModel {
  String? name;
  double? price;
  String? image;
  bool isFavorite;

  HotelModel({this.name, this.price, this.image, this.isFavorite = false});

  HotelModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        image = json['image'],
        isFavorite = json['isFavorite'] ?? false;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['isFavorite'] = this.isFavorite;
    return data;
  }
}