class ProductModel {
  final String title;
  final String price;
  final String image;
  final bool fav;

  ProductModel({required this.fav,required this.title, required this.price, required this.image});

  // factory ProductModel.fromMap(Map<String, dynamic> json) {
  //   return ProductModel(
  //     title: json['title'],
  //     price: json['price'].toString(),
  //     image: json['image'],
  //   );
  // }
  static ProductModel fromMap(Map<String, dynamic> json){
return ProductModel(
      title: json['title'],
      price: json['price'].toString(),
      image: json['image'],
      fav:false
    );
  }
}