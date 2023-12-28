import 'package:main_project/domain/model/product_model.dart';

abstract class CartEvent{}

class AddCartEvent extends CartEvent{
  final ProductModel product;

  AddCartEvent({required this.product});
}
class RemoveCartEvent extends CartEvent{
  final ProductModel product;

  RemoveCartEvent({required this.product});
}