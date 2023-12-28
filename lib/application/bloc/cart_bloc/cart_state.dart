import 'package:main_project/domain/model/product_model.dart';

class CartState {
  final Map<ProductModel,int> cartProduct;

  CartState({required this.cartProduct});
}

class InitialCartState extends CartState{
  InitialCartState() : super(cartProduct: {});
  
}